import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoGoogleNavigationViewProps } from './ExpoGoogleNavigation.types';

const NativeView: React.ComponentType<ExpoGoogleNavigationViewProps> =
  requireNativeView('ExpoGoogleNavigation');

export default function ExpoGoogleNavigationView(props: ExpoGoogleNavigationViewProps) {
  return <NativeView {...props} />;
}
