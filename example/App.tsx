import React, { useRef, useEffect } from 'react';
import { View, Button, StyleSheet, Text, Alert } from 'react-native';

export default function App() {
  const [moduleLoaded, setModuleLoaded] = React.useState(false);
  const [error, setError] = React.useState<string | null>(null);

  useEffect(() => {
    // Try to load the module and see what happens
    const testModule = async () => {
      try {
        // First, let's see what native modules are available
        const { NativeModulesProxy } = require('expo-modules-core');
        console.log('Available native modules:', Object.keys(NativeModulesProxy));
        console.log('Looking for ExpoGoogleNavigation in:', NativeModulesProxy);
        console.log('ExpoGoogleNavigation exists?', 'ExpoGoogleNavigation' in NativeModulesProxy);

        // Try to access the module directly
        if (NativeModulesProxy.ExpoGoogleNavigation) {
          console.log('ExpoGoogleNavigation found:', NativeModulesProxy.ExpoGoogleNavigation);
        } else {
          console.log('ExpoGoogleNavigation not found in NativeModulesProxy');
        }

        const { GoogleMapsNavigation, GoogleMapsNavigationModule } = await import('expo-google-navigation');
        console.log('GoogleMapsNavigation:', GoogleMapsNavigation);
        console.log('GoogleMapsNavigationModule:', GoogleMapsNavigationModule);
        setModuleLoaded(true);
      } catch (err) {
        console.error('Failed to load module:', err);
        setError(err instanceof Error ? err.message : 'Unknown error');
      }
    };

    testModule();
  }, []);

  if (error) {
    return (
      <View style={styles.container}>
        <Text style={styles.error}>Module Loading Error:</Text>
        <Text style={styles.errorText}>{error}</Text>
        <Button title="Retry" onPress={() => {
          setError(null);
          setModuleLoaded(false);
        }} />
      </View>
    );
  }

  if (!moduleLoaded) {
    return (
      <View style={styles.container}>
        <Text>Loading module...</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Text style={styles.success}>Module loaded successfully!</Text>
      <Text>You can now add Google Maps Navigation functionality.</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  error: {
    fontSize: 18,
    fontWeight: 'bold',
    color: 'red',
    marginBottom: 10,
  },
  errorText: {
    fontSize: 14,
    color: 'red',
    textAlign: 'center',
    marginBottom: 20,
  },
  success: {
    fontSize: 18,
    fontWeight: 'bold',
    color: 'green',
    marginBottom: 10,
  },
});