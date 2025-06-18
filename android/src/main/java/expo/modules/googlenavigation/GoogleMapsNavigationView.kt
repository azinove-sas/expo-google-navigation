package expo.modules.googlenavigation

import android.content.Context
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.FragmentManager
import com.google.android.libraries.navigation.NavigationApi
import com.google.android.libraries.navigation.Navigator
import com.google.android.libraries.navigation.SupportNavigationFragment
import com.google.android.libraries.navigation.Waypoint
import com.google.android.gms.maps.model.LatLng
import expo.modules.kotlin.AppContext
import expo.modules.kotlin.views.ExpoView

class GoogleMapsNavigationView(context: Context, appContext: AppContext) : ExpoView(context, appContext) {
  private var navigationFragment: SupportNavigationFragment? = null
  private var navigator: Navigator? = null
  private var isNavigationInitialized = false
  
  init {
    setupNavigationView()
  }
  
  private fun setupNavigationView() {
    // Initialize Google Navigation
    NavigationApi.getNavigator(
      context as FragmentActivity,
      object : NavigationApi.NavigatorListener {
        override fun onNavigatorReady(navigator: Navigator) {
          this@GoogleMapsNavigationView.navigator = navigator
          setupNavigationFragment()
        }
      }
    )
  }
  
  private fun setupNavigationFragment() {
    val activity = context as? FragmentActivity ?: return
    val fragmentManager: FragmentManager = activity.supportFragmentManager
    
    navigationFragment = SupportNavigationFragment.newInstance()
    val transaction = fragmentManager.beginTransaction()
    transaction.add(id, navigationFragment!!)
    transaction.commit()
  }
  
  fun setDestinations(destinations: List<Map<String, Any>>) {
    val waypoints = destinations.mapNotNull { dest ->
      val lat = dest["latitude"] as? Double
      val lng = dest["longitude"] as? Double
      if (lat != null && lng != null) {
        Waypoint.newBuilder()
          .setLocation(LatLng(lat, lng))
          .build()
      } else null
    }
    
    if (waypoints.isNotEmpty()) {
      navigator?.setDestinations(waypoints)
        ?.addOnSuccessListener { 
          isNavigationInitialized = true
        }
        ?.addOnFailureListener { exception ->
          // Handle error
        }
    }
  }
  
  fun setNavigationOptions(options: Map<String, Any>?) {
    // Apply navigation options like travel mode, avoid tolls, etc.
    options?.let { opts ->
      // Implementation depends on available Google Navigation SDK options
    }
  }
  
  fun setShowTraffic(showTraffic: Boolean) {
    navigationFragment?.getMapAsync { googleMap ->
      googleMap.isTrafficEnabled = showTraffic
    }
  }
  
  fun setShowSpeedLimits(showSpeedLimits: Boolean) {
    // Implementation depends on Google Navigation SDK capabilities
  }
  
  fun setNightMode(nightMode: Boolean) {
    navigationFragment?.getMapAsync { googleMap ->
      if (nightMode) {
        // Apply dark theme
      } else {
        // Apply light theme
      }
    }
  }
}