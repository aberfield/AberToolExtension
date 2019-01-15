#
# Be sure to run `pod lib lint AberToolExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AberToolExtension'
  s.version          = '0.0.5'
  s.summary          = '一些常用的第三方工具类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.一些常用的第三方工具类
                       DESC

  s.homepage         = 'https://github.com/aberfield/AberToolExtension'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aberfield' => 'liufangyou521@163.com' }
  s.source           = { :git => 'https://github.com/aberfield/AberToolExtension.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.swift_version    = '4.0'
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'AberToolExtension/**/*'
  
  # s.resource_bundles = {
  #   'AberToolExtension' => ['AberToolExtension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
