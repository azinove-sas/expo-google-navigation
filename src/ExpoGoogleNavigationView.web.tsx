import * as React from 'react';

import { ExpoGoogleNavigationViewProps } from './ExpoGoogleNavigation.types';

export default function ExpoGoogleNavigationView(props: ExpoGoogleNavigationViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
