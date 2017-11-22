# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'find_love' do
  use_frameworks!

  pod ‘UIView+Shake’
  pod ‘SearchTextField’, :inhibit_warnings=>true
  pod 'DynamicStickers'
  pod 'SwiftyJSON'
  pod 'SCPageViewController'
  pod 'PagingMenuController'
  pod 'Alamofire'
 
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
      if target.name == 'PagingMenuController'
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end
end
