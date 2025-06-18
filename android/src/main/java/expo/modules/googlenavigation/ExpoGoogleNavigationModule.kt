package expo.modules.googlenavigation

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition
import expo.modules.kotlin.Promise
import com.google.android.libraries.navigation.NavigationApi
import com.google.android.libraries.navigation.Navigator

class ExpoGoogleNavigationModule : Module() {
  private var navigator: Navigator? = null
  private var currentView: GoogleMapsNavigationView? = null

  // Each module class must implement the definition function. The definition consists of components
  // that describes the module's functionality and behavior.
  // See https://docs.expo.dev/modules/module-api for more details about available components.
  override fun definition() = ModuleDefinition {
    // Sets the name of the module that JavaScript code will use to refer to the module. Takes a string as an argument.
    // Can be inferred from module's class name, but it's recommended to set it explicitly for clarity.
    // The module will be accessible from `requireNativeModule('ExpoGoogleNavigation')` in JavaScript.
    Name("ExpoGoogleNavigation")

    // Defines event names that the module can send to JavaScript.
    Events("onNavigationStarted", "onNavigationFinished", "onRouteChanged", "onNavigationError")

    // Defines a JavaScript synchronous function that runs the native code on the JavaScript thread.
    Function("hello") {
      "Hello world! 👋"
    }

    AsyncFunction("initializeNavigation") { promise: Promise ->
      try {
        promise.resolve(null)
      } catch (e: Exception) {
        promise.reject("NAVIGATION_ERROR", "Failed to initialize navigation: ${e.message}", e)
      }
    }

    AsyncFunction("startNavigation") { promise: Promise ->
      try {
        navigator?.startGuidance()
        promise.resolve(null)
      } catch (e: Exception) {
        promise.reject("NAVIGATION_ERROR", "Failed to start navigation: ${e.message}", e)
      }
    }

    AsyncFunction("stopNavigation") { promise: Promise ->
      try {
        navigator?.stopGuidance()
        navigator?.clearDestinations()
        promise.resolve(null)
      } catch (e: Exception) {
        promise.reject("NAVIGATION_ERROR", "Failed to stop navigation: ${e.message}", e)
      }
    }

    AsyncFunction("pauseNavigation") { promise: Promise ->
      try {
        navigator?.stopGuidance()
        promise.resolve(null)
      } catch (e: Exception) {
        promise.reject("NAVIGATION_ERROR", "Failed to pause navigation: ${e.message}", e)
      }
    }

    AsyncFunction("resumeNavigation") { promise: Promise ->
      try {
        navigator?.startGuidance()
        promise.resolve(null)
      } catch (e: Exception) {
        promise.reject("NAVIGATION_ERROR", "Failed to resume navigation: ${e.message}", e)
      }
    }

    AsyncFunction("recalculateRoute") { promise: Promise ->
      try {
        // The Google Navigation SDK handles this automatically
        promise.resolve(null)
      } catch (e: Exception) {
        promise.reject("NAVIGATION_ERROR", "Failed to recalculate route: ${e.message}", e)
      }
    }

    // Enables the module to be used as a native view. Definition components that are accepted as part of
    // the view definition: Prop, Events.
    View(GoogleMapsNavigationView::class) {
      Events("onNavigationStarted", "onNavigationFinished", "onRouteChanged", "onNavigationError")
      
      Prop("destinations") { view: GoogleMapsNavigationView, destinations: List<Map<String, Any>> ->
        currentView = view
        navigator = view.navigator
        view.setDestinations(destinations)
      }
      
      Prop("options") { view: GoogleMapsNavigationView, options: Map<String, Any>? ->
        view.setNavigationOptions(options)
      }
      
      Prop("showTraffic") { view: GoogleMapsNavigationView, showTraffic: Boolean ->
        view.setShowTraffic(showTraffic)
      }
      
      Prop("showSpeedLimits") { view: GoogleMapsNavigationView, showSpeedLimits: Boolean ->
        view.setShowSpeedLimits(showSpeedLimits)
      }
      
      Prop("nightMode") { view: GoogleMapsNavigationView, nightMode: Boolean ->
        view.setNightMode(nightMode)
      }
    }
  }
}
