# expo-google-navigation

A React Native Expo module that integrates Google Maps with navigation functionality, providing turn-by-turn directions and mapping capabilities for your mobile applications.

## Features

- 🗺️ **Google Maps Integration**: Display interactive maps with markers and routes
- 🧭 **Navigation Support**: Basic navigation functionality with destination markers
- 🚦 **Traffic Information**: Toggle traffic layer on/off
- 🌙 **Dark Mode**: Night mode styling support
- 📍 **Location Services**: My Location button and user location display
- 🎯 **Destination Management**: Set multiple destinations with custom markers
- ⚡ **Performance Optimized**: Built on native Google Maps SDKs

## Requirements

- **Expo SDK 51+**
- **iOS 15.0+** / **Android API 21+**
- **Google Maps Platform API Key** with the following APIs enabled:
  - Maps SDK for Android
  - Maps SDK for iOS
  - Navigation SDK for Android (optional, for advanced features)
  - Navigation SDK for iOS (optional, for advanced features)

## Installation

### For Managed Expo Projects

```bash
npx expo install expo-google-navigation
```

### For Bare React Native Projects

Ensure you have [installed and configured the `expo` package](https://docs.expo.dev/bare/installing-expo-modules/) before continuing.

```bash
npm install expo-google-navigation
```

## Configuration

### 1. Get Google Maps API Key

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the Maps SDK for Android and iOS
4. Create credentials (API Key)
5. Restrict the API key to your bundle identifiers

### 2. Configure for Android

Add your API key to `android/app/src/main/AndroidManifest.xml`:

```xml
<application>
  <!-- Add this inside the <application> tag -->
  <meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY" />
</application>
```

### 3. Configure for iOS

Add your API key to your `app.json` or `app.config.js`:

```json
{
  "expo": {
    "plugins": [
      [
        "expo-google-navigation",
        {
          "iosApiKey": "YOUR_GOOGLE_MAPS_API_KEY"
        }
      ]
    ]
  }
}
```

For bare React Native projects, run:
```bash
npx pod-install
```

### 4. Add API Key to App Delegate (iOS - Bare React Native only)

Add the following to your `ios/YourApp/AppDelegate.swift`:

```swift
import GoogleMaps

// In application:didFinishLaunchingWithOptions:
GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
```

## Usage

### Basic Map with Destinations

```typescript
import { GoogleMapsNavigation } from 'expo-google-navigation';
import { StyleSheet, View } from 'react-native';

export default function App() {
  const destinations = [
    {
      latitude: 37.7749,
      longitude: -122.4194,
      title: "San Francisco"
    },
    {
      latitude: 37.7849,
      longitude: -122.4094,
      title: "Destination 2"
    }
  ];

  return (
    <View style={styles.container}>
      <GoogleMapsNavigation
        style={styles.map}
        destinations={destinations}
        showTraffic={true}
        showSpeedLimits={false}
        nightMode={false}
        onNavigationStarted={() => console.log('Navigation started')}
        onNavigationFinished={() => console.log('Navigation finished')}
        onRouteChanged={(event) => console.log('Route changed:', event)}
        onNavigationError={(event) => console.log('Navigation error:', event)}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  map: {
    flex: 1,
  },
});
```

### Navigation Controls

```typescript
import * as GoogleNavigation from 'expo-google-navigation';

// Initialize navigation
await GoogleNavigation.initializeNavigation();

// Start navigation
await GoogleNavigation.startNavigation();

// Pause navigation
await GoogleNavigation.pauseNavigation();

// Resume navigation
await GoogleNavigation.resumeNavigation();

// Stop navigation
await GoogleNavigation.stopNavigation();

// Recalculate route
await GoogleNavigation.recalculateRoute();
```

## API Reference

### Components

#### `GoogleMapsNavigation`

A React component that displays a Google Map with navigation capabilities.

**Props:**
- `destinations` (Array): Array of destination objects with `latitude`, `longitude`, and optional `title`
- `showTraffic` (boolean): Enable/disable traffic layer
- `showSpeedLimits` (boolean): Enable/disable speed limit display
- `nightMode` (boolean): Enable/disable dark mode styling
- `options` (object): Additional navigation options
- `onNavigationStarted` (function): Callback when navigation starts
- `onNavigationFinished` (function): Callback when navigation ends
- `onRouteChanged` (function): Callback when route changes
- `onNavigationError` (function): Callback when navigation error occurs

### Methods

- `initializeNavigation()`: Initialize the navigation system
- `startNavigation()`: Start turn-by-turn navigation
- `stopNavigation()`: Stop navigation and clear route
- `pauseNavigation()`: Pause navigation guidance
- `resumeNavigation()`: Resume paused navigation
- `recalculateRoute()`: Recalculate the current route

## Platform-Specific Notes

### iOS
- Requires iOS 15.0 or later
- Uses Google Maps SDK for iOS and Google Navigation SDK for iOS
- API key must be configured in app configuration

### Android
- Requires Android API level 21 or later
- Uses Google Maps SDK for Android and Google Navigation SDK for Android
- API key must be added to AndroidManifest.xml

## Troubleshooting

### Common Issues

1. **Map not displaying**: Ensure your API key is correctly configured and has the necessary permissions
2. **Navigation not working**: Check that your Google Cloud project has Navigation SDK enabled
3. **Build errors on iOS**: Run `npx pod-install` after installation
4. **Build errors on Android**: Ensure your `android/build.gradle` has the correct Google Services plugin

### Getting Help

- Check the [troubleshooting guide](https://developers.google.com/maps/documentation/navigation)
- Review [Google Maps Platform documentation](https://developers.google.com/maps/documentation)
- Open an issue in this repository

## Example App

A complete example app is available in the `example/` directory. To run it:

```bash
cd example
npm install
npx expo run:ios # or npx expo run:android
```

## Contributing

Contributions are very welcome! Please refer to guidelines described in the [contributing guide](https://github.com/expo/expo#contributing).

### Development Setup

1. Clone the repository
2. Install dependencies: `npm install`
3. Navigate to example: `cd example && npm install`
4. Add your Google Maps API key to `example/app.json`
5. Run the example app: `npx expo run:ios` or `npx expo run:android`

## License

MIT License - see LICENSE file for details.

## Acknowledgments

- Built with [Expo Modules API](https://docs.expo.dev/modules/overview/)
- Powered by [Google Maps Platform](https://developers.google.com/maps)
- Uses [Google Navigation SDK](https://developers.google.com/maps/documentation/navigation)
