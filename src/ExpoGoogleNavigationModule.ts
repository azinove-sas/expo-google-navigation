import { NativeModule, requireNativeModule } from 'expo';

import { ExpoGoogleNavigationModuleEvents } from './ExpoGoogleNavigation.types';

declare class ExpoGoogleNavigationModule extends NativeModule<ExpoGoogleNavigationModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoGoogleNavigationModule>('ExpoGoogleNavigation');
