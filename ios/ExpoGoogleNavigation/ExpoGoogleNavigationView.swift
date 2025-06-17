import ExpoModulesCore
import UIKit

// This view will be used as a native component for Google Maps Navigation.
// Make sure to inherit from `ExpoView` to apply the proper styling (e.g. border radius and shadows).
class ExpoGoogleNavigationView: ExpoView {
  private let mapView = UIView() // Placeholder for actual Google Maps Navigation view
  
  // Event dispatchers
  private let onNavigationStarted = EventDispatcher()
  private let onNavigationFinished = EventDispatcher()
  private let onRouteChanged = EventDispatcher()
  private let onNavigationError = EventDispatcher()

  required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext)
    clipsToBounds = true
    setupMapView()
  }
  
  private func setupMapView() {
    mapView.backgroundColor = UIColor.lightGray
    addSubview(mapView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    mapView.frame = bounds
  }
  
  // MARK: - Public methods for props
  
  func setDestinations(_ destinations: [[String: Any]]) {
    // TODO: Implement setting destinations with Google Navigation SDK
    print("Setting destinations: \(destinations)")
  }
  
  func setNavigationOptions(_ options: [String: Any]?) {
    // TODO: Implement setting navigation options
    print("Setting navigation options: \(options ?? [:])")
  }
  
  func setShowTraffic(_ showTraffic: Bool) {
    // TODO: Implement showing/hiding traffic
    print("Setting show traffic: \(showTraffic)")
  }
  
  func setShowSpeedLimits(_ showSpeedLimits: Bool) {
    // TODO: Implement showing/hiding speed limits
    print("Setting show speed limits: \(showSpeedLimits)")
  }
  
  func setNightMode(_ nightMode: Bool) {
    // TODO: Implement night mode
    print("Setting night mode: \(nightMode)")
  }
} 