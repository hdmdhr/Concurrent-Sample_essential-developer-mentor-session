# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

workspace 'Concurrent Nudge'


def app_pods
  pod 'netfox'#, :configurations => ['Debug']
  pod 'IQKeyboardManagerSwift'
  pod 'Kingfisher', '~> 7'
  pod 'Swinject'
end


target 'Core' do
  project 'Core/Core.xcodeproj'
end

target 'Data' do
  project 'Data/Data.xcodeproj'
end

target 'Application' do
  project 'Application/Application.xcodeproj'

  # Pods for Concurrent Nudge
  app_pods

  target 'ApplicationTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ApplicationUITests' do
    # Pods for testing
  end

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
