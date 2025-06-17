import React, { useImperativeHandle, forwardRef } from 'react';
import { requireNativeViewManager } from 'expo-modules-core';
import { NavigationProps, NavigationMethods } from './GoogleMapsNavigation.types';
import GoogleMapsNavigationModule from './GoogleMapsNavigationModule';

const NativeView: React.ComponentType<any> = requireNativeViewManager('ExpoGoogleNavigation');

export const GoogleMapsNavigation = forwardRef<NavigationMethods, NavigationProps>(
    (props, ref) => {
        useImperativeHandle(ref, () => ({
            startNavigation: async () => {
                return GoogleMapsNavigationModule.startNavigation();
            },
            stopNavigation: async () => {
                return GoogleMapsNavigationModule.stopNavigation();
            },
            pauseNavigation: async () => {
                return GoogleMapsNavigationModule.pauseNavigation();
            },
            resumeNavigation: async () => {
                return GoogleMapsNavigationModule.resumeNavigation();
            },
            recalculateRoute: async () => {
                return GoogleMapsNavigationModule.recalculateRoute();
            },
        }));

        return (
            <NativeView
                style={props.style}
                destinations={props.destinations}
                options={props.options}
                showTraffic={props.showTraffic}
                showSpeedLimits={props.showSpeedLimits}
                nightMode={props.nightMode}
                onNavigationStarted={props.onNavigationStarted}
                onNavigationFinished={props.onNavigationFinished}
                onRouteChanged={props.onRouteChanged}
                onNavigationError={props.onNavigationError}
            />
        );
    }
);