import { ConfigPlugin, withAndroidManifest, withInfoPlist } from '@expo/config-plugins';

const withGoogleMapsNavigation: ConfigPlugin<{
  androidApiKey?: string;
  iosApiKey?: string;
}> = (config, { androidApiKey, iosApiKey } = {}) => {
  // Android configuration
  config = withAndroidManifest(config, (config) => {
    const androidManifest = config.modResults;
    
    if (androidApiKey) {
      // Add API key to AndroidManifest.xml
      if (!androidManifest.manifest.application) {
        androidManifest.manifest.application = [{ $: { 'android:name': '.MainApplication' } }];
      }
      
      const application = androidManifest.manifest.application?.[0];
      if (application) {
        if (!application['meta-data']) {
          application['meta-data'] = [];
        }
        
        application['meta-data'].push({
          $: {
            'android:name': 'com.google.android.geo.API_KEY',
            'android:value': androidApiKey,
          },
        });
      }
    }
    
    // Add required permissions
    if (!androidManifest.manifest['uses-permission']) {
      androidManifest.manifest['uses-permission'] = [];
    }
    
    const permissions = [
      'android.permission.ACCESS_FINE_LOCATION',
      'android.permission.ACCESS_COARSE_LOCATION',
      'android.permission.INTERNET',
    ];
    
    permissions.forEach((permission) => {
      androidManifest.manifest['uses-permission']?.push({
        $: { 'android:name': permission },
      });
    });
    
    return config;
  });

  // iOS configuration  
  config = withInfoPlist(config, (config) => {
    if (iosApiKey) {
      config.modResults.GMSApiKey = iosApiKey;
    }
    
    // Add required permissions
    config.modResults.NSLocationAlwaysAndWhenInUseUsageDescription = 
      'This app needs location access for navigation.';
    config.modResults.NSLocationWhenInUseUsageDescription = 
      'This app needs location access for navigation.';
    
    return config;
  });

  // Note: Google Navigation SDK is available through the standard CocoaPods repository
  // No additional Podfile modification needed for iOS

  return config;
};

export default withGoogleMapsNavigation;