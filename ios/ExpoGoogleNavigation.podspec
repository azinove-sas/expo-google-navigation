Pod::Spec.new do |s|
  s.name           = 'ExpoGoogleNavigation'
  s.version        = '0.1.0'
  s.summary        = 'Google turn by turn navigation for Expo'
  s.description    = 'A Google Maps Navigation SDK integration for Expo applications'
  s.author         = 'patrick-eiermann'
  s.homepage       = 'https://github.com/azinove-sas/expo-google-navigation'
  s.platforms      = { :ios => '13.4', :tvos => '13.4' }
  s.source         = { git: '' }
  s.static_framework = true

  s.dependency 'ExpoModulesCore'

  # Swift/Objective-C compatibility
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'SWIFT_COMPILATION_MODE' => 'wholemodule'
  }

  s.source_files = "ExpoGoogleNavigation/**/*.{h,m,mm,swift,hpp,cpp}"
end 