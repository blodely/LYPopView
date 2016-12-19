#
# Created By Luo Yu

Pod::Spec.new do |s|
  s.name             = 'LYPopView'
  s.version          = '0.1.2'
  s.summary          = 'pop view.'

  s.description      = <<-DESC
a pop view.
                       DESC

  s.homepage         = 'https://github.com/blodely/LYPopView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luo Yu' => 'indie.luo@gmail.com' }
  s.source           = { :git => 'https://github.com/blodely/LYPopView.git', :tag => s.version.to_s }

  s.social_media_url = 'https://weibo.com/blodely'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LYPopView/Classes/**/*'
  
  s.resource_bundles = {
    'LYPopView' => ['LYPopView/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
