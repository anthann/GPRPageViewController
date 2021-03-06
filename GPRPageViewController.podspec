#
# Be sure to run `pod lib lint GPRPageViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GPRPageViewController"
  s.version          = "0.3.0"
  s.summary          = "A pageViewController with a nice titleBar on the top."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This is a encapsu of UIPageViewController, which provide a nice titleBar (like scrollable segmented control) on the top.  
  By add this viewController as childViewController and implement the delegate of it, it will takes every thing for you.
                       DESC

  s.homepage         = "https://github.com/anthann/GPRPageViewController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "anthann" => "72115165g@gmail.com" }
  s.source           = { :git => "https://github.com/anthann/GPRPageViewController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GPRPageViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GPRPageViewController' => ['GPRPageViewController/Assets/*.png']
  # }

  s.public_header_files = 'GPRPageViewController/Classes/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Masonry', '~> 1.0.0'
end
