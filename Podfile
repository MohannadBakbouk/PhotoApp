# Uncomment the next line to define a global platform for your project
 platform :ios, '14.2'

def appPods
   pod 'RxSwift', '6.2.0'
   pod 'RxCocoa', '6.2.0'
   pod 'Kingfisher', '~> 7.0'
   pod 'SnapKit', '~> 5.0.0'
   pod 'MaterialComponents/ActivityIndicator'
end


target 'PhotoApp' do
  use_frameworks!
  appPods

  target 'PhotoAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PhotoAppUITests' do
    # Pods for testing
  end

end
