export interface NavigationDestination {
    latitude: number;
    longitude: number;
    title?: string;
    address?: string;
  }
  
  export interface NavigationOptions {
    avoidTolls?: boolean;
    avoidHighways?: boolean;
    avoidFerries?: boolean;
    travelMode?: 'driving' | 'walking' | 'cycling' | 'transit';
  }
  
  export interface NavigationProps {
    destinations: NavigationDestination[];
    options?: NavigationOptions;
    showTraffic?: boolean;
    showSpeedLimits?: boolean;
    nightMode?: boolean;
    onNavigationStarted?: () => void;
    onNavigationFinished?: () => void;
    onRouteChanged?: (route: any) => void;
    onNavigationError?: (error: string) => void;
    style?: any;
  }
  
  export interface NavigationMethods {
    startNavigation: () => Promise<void>;
    stopNavigation: () => Promise<void>;
    pauseNavigation: () => Promise<void>;
    resumeNavigation: () => Promise<void>;
    recalculateRoute: () => Promise<void>;
  }