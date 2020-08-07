#
# Be sure to run `pod lib lint LCRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LCRouter'
  s.version          = '0.0.2'
  s.summary          = '路由组件'
  s.description      = '用于各个组件间的页面跳转'

  s.homepage         = 'https://github.com/1051390159/LCRouter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liubin' => '1051390159@qq.com' }
  s.source           = { :git => 'https://github.com/1051390159/LCRouter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.public_header_files = 'LCRouter/Classes/LCRouterHeader.h'
  s.source_files = 'LCRouter/Classes/LCRouterHeader.h'
  
  s.subspec 'Router' do |router|
     router.source_files = 'LCRouter/Classes/Router/**/*'
   end
  
  # s.resource_bundles = {
  #   'LCRouter' => ['LCRouter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
