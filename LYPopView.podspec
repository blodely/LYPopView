#
# Created By Luo Yu

Pod::Spec.new do |s|
	s.name             = 'LYPopView'
	s.version          = '0.1.13'
	s.summary          = 'pop view.'

	s.description      = <<-DESC
a pop view.
message, table, date, button, etc.
					   DESC

	s.homepage         = 'https://github.com/blodely/LYPopView'
	# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'

	s.license          = { :type => 'MIT', :file => 'LICENSE' }
	s.author           = { 'Luo Yu' => 'indie.luo@gmail.com' }
	s.source           = { :git => 'https://github.com/blodely/LYPopView.git', :tag => s.version.to_s }

	s.social_media_url = 'https://weibo.com/blodely'

	s.ios.deployment_target = '7.0'

	s.source_files = 'LYPopView/Classes/action/*', 'LYPopView/Classes/dropdown/*', 'LYPopView/Classes/picker/*', 'LYPopView/Classes/picker_date/*', 'LYPopView/Classes/pop_message/*', 'LYPopView/Classes/pop_table/*', 'LYPopView/Classes/pop_date/*', 'LYPopView/Classes/**/*', 'LYPopView/Configurations/*.plist'

	s.resource_bundles = {
	'LYPopView' => ['LYPopView/Assets/*.png']
	}

	# s.public_header_files = 'Pod/Classes/**/*.h'
	# s.frameworks = 'UIKit', 'MapKit'

	s.frameworks = 'UIKit'

	s.dependency 'LYCategory'
	s.dependency 'FCFileManager', '~> 1.0.18'

end
