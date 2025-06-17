import React, { useRef } from 'react';
import { View, Button, StyleSheet } from 'react-native';
import { GoogleMapsNavigation, NavigationMethods } from 'expo-google-navigation';

export default function App() {
  const navigationRef = useRef<NavigationMethods>(null);

  const startNavigation = () => {
    navigationRef.current?.startNavigation();
  };

  const stopNavigation = () => {
    navigationRef.current?.stopNavigation();
  };

  return (
    <View style={styles.container}>
      <GoogleMapsNavigation
        ref={navigationRef}
        style={styles.map}
        destinations={[
          {
            latitude: 37.7749,
            longitude: -122.4194,
            title: 'San Francisco',
          },
        ]}
        options={{
          travelMode: 'driving',
          avoidTolls: false,
        }}
        showTraffic={true}
        showSpeedLimits={true}
        onNavigationStarted={() => console.log('Navigation started')}
        onNavigationFinished={() => console.log('Navigation finished')}
        onNavigationError={(error) => console.error('Navigation error:', error)}
      />

      <View style={styles.controls}>
        <Button title="Start Navigation" onPress={startNavigation} />
        <Button title="Stop Navigation" onPress={stopNavigation} />
      </View>
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
  controls: {
    padding: 20,
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
});