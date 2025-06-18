Pod::Spec.new do |s|
  s.name           = 'ExpoGoogleNavigation'
  s.version        = '0.1.0'
  s.summary        = 'Google turn by turn navigation for Expo'
  s.description    = 'A Google Maps Navigation SDK integration for Expo applications'
  s.author         = 'patrick-eiermann'
  s.homepage       = 'https://github.com/azinove-sas/expo-google-navigation'
  s.license        = 'MIT'
  s.platforms      = { :ios => '15.0' }
  s.source         = { git: 'https://github.com/azinove-sas/expo-google-navigation.git', tag: s.version.to_s }
  s.static_framework = true

  s.dependency 'ExpoModulesCore'
  
  # Add Google Navigation SDK dependency (includes GoogleMaps)
  s.dependency 'GoogleNavigation', '~> 9.4.0'

  # Swift/Objective-C compatibility
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'SWIFT_COMPILATION_MODE' => 'wholemodule',
    'SWIFT_VERSION' => '5.0'
  }

  s.source_files = "ExpoGoogleNavigation/**/*.{h,m,mm,swift,hpp,cpp}"
end 