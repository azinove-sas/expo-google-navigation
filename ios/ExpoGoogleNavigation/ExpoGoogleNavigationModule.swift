import ExpoModulesCore

public class ExpoGoogleNavigationModule: Module {
  // Each module class must implement the definition function. The definition consists of components
  // that describes the module's functionality and behavior.
  // See https://docs.expo.dev/modules/module-api for more details about available components.
  public func definition() -> ModuleDefinition {
    // Sets the name of the module that JavaScript code will use to refer to the module.
    // The module will be accessible from `requireNativeModule('ExpoGoogleNavigation')` in JavaScript.
    Name("ExpoGoogleNavigation")

    // Defines event names that the module can send to JavaScript.
    Events("onNavigationStarted", "onNavigationFinished", "onRouteChanged", "onNavigationError")

    // Defines a JavaScript synchronous function that runs the native code on the JavaScript thread.
    Function("hello") {
      return "Hello world! 👋"
    }

    AsyncFunction("initializeNavigation") { (promise: Promise) in
      // TODO: Initialize navigation if needed
      promise.resolve(nil)
    }

    AsyncFunction("startNavigation") { (promise: Promise) in
      // TODO: Implement proper navigation start logic
      promise.resolve(nil)
    }

    AsyncFunction("stopNavigation") { (promise: Promise) in
      // TODO: Implement proper navigation stop logic
      promise.resolve(nil)
    }

    AsyncFunction("pauseNavigation") { (promise: Promise) in
      // TODO: Implement proper navigation pause logic
      promise.resolve(nil)
    }

    AsyncFunction("resumeNavigation") { (promise: Promise) in
      // TODO: Implement proper navigation resume logic
      promise.resolve(nil)
    }

    AsyncFunction("recalculateRoute") { (promise: Promise) in
      // TODO: Implement route recalculation logic
      promise.resolve(nil)
    }

    // Enables the module to be used as a native view. Definition components that are accepted as part of
    // the view definition: Prop, Events.
    View(ExpoGoogleNavigationView.self) {
      Events("onNavigationStarted", "onNavigationFinished", "onRouteChanged", "onNavigationError")
      
      Prop("destinations") { (view: ExpoGoogleNavigationView, destinations: [[String: Any]]) in
        view.setDestinations(destinations)
      }
      
      Prop("options") { (view: ExpoGoogleNavigationView, options: [String: Any]?) in
        view.setNavigationOptions(options)
      }
      
      Prop("showTraffic") { (view: ExpoGoogleNavigationView, showTraffic: Bool) in
        view.setShowTraffic(showTraffic)
      }
      
      Prop("showSpeedLimits") { (view: ExpoGoogleNavigationView, showSpeedLimits: Bool) in
        view.setShowSpeedLimits(showSpeedLimits)
      }
      
      Prop("nightMode") { (view: ExpoGoogleNavigationView, nightMode: Bool) in
        view.setNightMode(nightMode)
      }
    }
  }
} 