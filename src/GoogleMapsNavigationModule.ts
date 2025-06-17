import { NativeModule, requireNativeModule } from 'expo-modules-core';

declare class GoogleMapsNavigationModuleType extends NativeModule {
  startNavigation(): Promise<void>;
  stopNavigation(): Promise<void>;
  pauseNavigation(): Promise<void>;
  resumeNavigation(): Promise<void>;
  recalculateRoute(): Promise<void>;
  setDestinations(destinations: any[]): Promise<void>;
}

export default requireNativeModule<GoogleMapsNavigationModuleType>('ExpoGoogleNavigation');