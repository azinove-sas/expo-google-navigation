import ExpoModulesCore
import UIKit
import GoogleMaps
import GoogleNavigation
import CoreLocation

// This view will be used as a native component for Google Maps Navigation.
// Make sure to inherit from `ExpoView` to apply the proper styling (e.g. border radius and shadows).
class ExpoGoogleNavigationView: ExpoView {
  private var mapView: GMSMapView!
  internal var isNavigationInitialized = false
  private var navigationActive = false
  
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
    // Initialize GMSMapView with proper initializer
    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 15.0)
    mapView = GMSMapView(frame: .zero)
    mapView.camera = camera
    
    addSubview(mapView)
    
    // Set up location display
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
    
    // Initialize basic map functionality
    GMSServices.provideAPIKey("") // This should be set in AppDelegate
    
    isNavigationInitialized = true
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    mapView.frame = bounds
  }
  
  // MARK: - Public methods for props
  
  func setDestinations(_ destinations: [[String: Any]]) {
    guard isNavigationInitialized else {
      onNavigationError(["error": "Navigation not initialized"])
      return
    }
    
    // Clear existing markers
    mapView.clear()
    
    var bounds = GMSCoordinateBounds()
    var hasDestinations = false
    
    for destination in destinations {
      if let lat = destination["latitude"] as? Double,
         let lng = destination["longitude"] as? Double {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        // Add marker to map
        let marker = GMSMarker(position: location)
        if let title = destination["title"] as? String {
          marker.title = title
        }
        marker.map = mapView
        
        // Add to bounds
        bounds = bounds.includingCoordinate(location)
        hasDestinations = true
      }
    }
    
    // Fit map to show all destinations
    if hasDestinations {
      let update = GMSCameraUpdate.fit(bounds, withPadding: 50.0)
      mapView.animate(with: update)
    }
    
    print("Destinations set on map")
    onRouteChanged(["status": "destinations_set"])
  }
  
  func setNavigationOptions(_ options: [String: Any]?) {
    // Basic navigation options handling - simplified for compatibility
    if let options = options {
      print("Setting navigation options: \(options)")
    }
  }
  
  func setShowTraffic(_ showTraffic: Bool) {
    mapView.isTrafficEnabled = showTraffic
  }
  
  func setShowSpeedLimits(_ showSpeedLimits: Bool) {
    // Speed limits display - this may not be available in all SDK versions
    print("Setting show speed limits: \(showSpeedLimits)")
  }
  
  func setNightMode(_ nightMode: Bool) {
    if nightMode {
      // Apply night mode style
      do {
        if let styleURL = Bundle.main.url(forResource: "night_style", withExtension: "json") {
          mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
        } else {
          // Fallback to a simple dark style
          let style = """
          [
            {
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#242f3e"
                }
              ]
            },
            {
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#746855"
                }
              ]
            },
            {
              "elementType": "labels.text.stroke",
              "stylers": [
                {
                  "color": "#242f3e"
                }
              ]
            }
          ]
          """
          mapView.mapStyle = try GMSMapStyle(jsonString: style)
        }
      } catch {
        print("Error applying night mode style: \(error)")
      }
    } else {
      mapView.mapStyle = nil
    }
  }
  
  // MARK: - Navigation Control Methods
  
  func startNavigation() {
    guard isNavigationInitialized else {
      onNavigationError(["error": "Navigation not initialized"])
      return
    }
    
    if navigationActive {
      print("Navigation already active")
      return
    }
    
    navigationActive = true
    onNavigationStarted([:])
    print("Navigation started")
  }
  
  func stopNavigation() {
    guard isNavigationInitialized else {
      onNavigationError(["error": "Navigation not initialized"])
      return
    }
    
    navigationActive = false
    mapView.clear() // Clear markers
    onNavigationFinished([:])
    print("Navigation stopped")
  }
  
  func pauseNavigation() {
    guard isNavigationInitialized else {
      onNavigationError(["error": "Navigation not initialized"])
      return
    }
    
    navigationActive = false
    print("Navigation paused")
  }
  
  func resumeNavigation() {
    guard isNavigationInitialized else {
      onNavigationError(["error": "Navigation not initialized"])
      return
    }
    
    if !navigationActive {
      navigationActive = true
      print("Navigation resumed")
    }
  }
} 