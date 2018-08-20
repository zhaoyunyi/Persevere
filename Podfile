# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!


def business_common_pods

    pod 'R.swift', '~> 5.0.0.alpha.1'
    pod 'RxSwift', '~> 4.2.0'
    pod 'RxCocoa', '~> 4.2.0'
    pod 'RxDataSources', '~> 3.0.2'
    pod 'SnapKit', '~> 4.0.0'

end

target 'PersevereiOS' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  business_common_pods

  target 'PersevereiOSTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PersevereiOSUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
