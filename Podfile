# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SpritualTablets' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

pod 'Firebase/Core'
pod 'Firebase/Database'
pod 'Firebase/Auth'
pod 'Firebase/Analytics'
pod 'Firebase/RemoteConfig'
pod 'Firebase/Firestore'
pod 'Toast-Swift' #, '~> 2.0.0'
pod 'GoogleSignIn'
pod 'SwiftOverlays'
pod 'IQKeyboardManagerSwift'

  # Pods for SpritualTablets

end
 post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
       config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
         config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "13.0"
         xcconfig_path = config.base_configuration_reference.real_path
         xcconfig = File.read(xcconfig_path)
         xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
         File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
         end
       end
   end