# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!


def business_common_pods

    pod 'R.swift', '~> 4.0.0'
    pod 'RxSwift', '~> 4.2.0'
    pod 'RxCocoa', '~> 4.2.0'
    pod 'RxDataSources', '~> 3.0.2'
    pod 'SnapKit', '~> 4.0.0'
    pod 'URLNavigator', '~> 2.0.6'
    pod 'Moya/RxSwift', '~> 11.0.2'
    pod 'ObjectMapper', '~> 3.3.0'
    pod 'XCGLogger', '~> 6.0.4'
    pod 'RealmSwift', '~> 3.7.6'
        
    pod 'Socket.IO-Client-Swift', '~> 13.3.0'
    pod 'SDWebImage', '~> 5.0.0-beta2'
    pod 'TZImagePickerController', '~> 2.2.5'
    pod 'SwiftDate', '~> 5.0.5'
    pod 'IQKeyboardManagerSwift', '~> 6.1.1'
    pod 'DeviceKit', '~> 1.7.0'
    pod 'Toast-Swift', '~> 3.0.1'
    
    pod 'MJRefresh', '~> 3.1.15.6'
    pod 'PopupDialog', '~> 0.8.1'
    pod 'WZLBadge', '~> 1.2.6'
    pod 'DZNEmptyDataSet', '~> 1.8.1'
    pod 'YYText', '~> 1.0.7'
    pod 'LCActionSheet', '~> 3.5.0'
    pod 'MBProgressHUD', '~> 1.1.0'
    pod 'ETNavBarTransparent', '~> 1.1.2'
    
    pod 'pop', '~> 1.0.10'
    pod 'Spring', '~> 1.0.5'
    
    pod 'Fabric', '~> 1.7.11'
    
    
end

target 'PersevereiOS' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  business_common_pods

  target 'PersevereiOSTests' do
    inherit! :search_paths
    
  end

  target 'PersevereiOSUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            #if  target.name == "PopupDialog" || target.name == "XCGLogger" || target.name == "ETNavBarTransparent"
            #               target.build_configurations.each do |config|
            #                   config.build_settings['SWIFT_VERSION'] = '3.2'
            #               end
            #           end
        end
    end
end
