# Uncomment the next line to define a global platform for your project
platform :ios, '11.2'

target 'pokeFW' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for pokeFW
    pod 'AlamofireImage'
    pod 'CodableAlamofire'
    pod 'KeychainSwift'

  target 'pokeFWTests' do
    # Pods for testing
    pod 'AlamofireImage'
    pod 'CodableAlamofire'
    pod 'KeychainSwift'
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
        end
    end
end
