// Reexport the native module. On web, it will be resolved to ExpoGoogleNavigationModule.web.ts
// and on native platforms to ExpoGoogleNavigationModule.ts
export { default } from './ExpoGoogleNavigationModule';
export { default as ExpoGoogleNavigationView } from './ExpoGoogleNavigationView';
export * from  './ExpoGoogleNavigation.types';
