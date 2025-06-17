import { registerWebModule, NativeModule } from 'expo';

import { ExpoGoogleNavigationModuleEvents } from './ExpoGoogleNavigation.types';

class ExpoGoogleNavigationModule extends NativeModule<ExpoGoogleNavigationModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpoGoogleNavigationModule, 'ExpoGoogleNavigationModule');
