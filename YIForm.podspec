#
# Be sure to run `pod lib lint YIForm.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YIForm'
  s.version          = '0.2.1'
  s.summary          = 'iOS 常用复杂表单'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOS 常用复杂表单.
iOS 常用复杂表单.
iOS 常用复杂表单.
iOS 常用复杂表单.
                       DESC

  s.homepage         = 'https://github.com/yiliazhang/YIForm'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yiliazhang' => '609486964@qq.com' }
  s.source           = { :git => 'https://github.com/yiliazhang/YIForm.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files  = "YIForm", "YIForm/Classes/*.{h,m,swift}"
   s.resource_bundles = {
     'YIForm' => ['YIForm/Assets/*.png']
   }

  #s.public_header_files = 'Pod/Classes/YIForm.h'
  # s.frameworks = 'UIKit'
  # s.dependency 'Masonry'
end
