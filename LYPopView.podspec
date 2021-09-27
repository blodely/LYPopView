#
# Created By Luo Yu

Pod::Spec.new do |s|
	s.name             = 'LYPopView'
	s.version          = '1.13.0'
	s.summary          = 'pop view.'

	s.description      = <<-DESC
a pop view.
message, table, date, button, etc.
Versions:
  1.0.x=>iOS7;
  1.12.x=>Xcode12.iOS9.
  1.13.x => iOS 11+.
					   DESC

	s.homepage         = 'https://github.com/blodely/LYPopView'
	# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'

	s.license          = { :type => 'MIT', :file => 'LICENSE' }
	s.author           = { 'Luo Yu' => 'indie.luo@gmail.com' }
	s.source           = { :git => 'https://github.com/blodely/LYPopView.git', :tag => s.version.to_s }

	s.social_media_url = 'https://weibo.com/blodely'

	s.ios.deployment_target = '11.0'

	s.source_files = 'LYPopView/Classes/*', 'LYPopView/Classes/action/*', 'LYPopView/Classes/hover/*', 'LYPopView/Classes/dropdown/*', 'LYPopView/Classes/picker/*', 'LYPopView/Classes/picker_date/*', 'LYPopView/Classes/picker_list/*', 'LYPopView/Classes/pop_message/*', 'LYPopView/Classes/pop_table/*', 'LYPopView/Classes/pop_date/*', 'LYPopView/Classes/pop_image/*'

	s.resources = 'LYPopView/Configurations/*.plist'

	s.resource_bundles = {
		'LYPopView' => ['LYPopView/Assets/*.png']
	}

	# s.public_header_files = 'Pod/Classes/**/*.h'
	# s.frameworks = 'UIKit', 'MapKit'

	s.frameworks = 'UIKit', 'WebKit'

	s.dependency 'LYCategory', '~> 1.12.2'
	s.dependency 'FCFileManager', '~> 1.0.20'
	s.dependency 'AFNetworking', '~> 4.0'
	s.dependency 'Masonry', '~> 1.1.0'

end
