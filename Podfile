# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'RxSwiftExample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
	inhibit_all_warnings!
	
	# Rx
	pod 'RxSwift', '~> 4.0'
	pod 'RxCocoa', '~> 4.0'
	pod 'RxViewController'
	pod 'RxDataSources', '~> 3.0'
	pod 'Moya/RxSwift', '~> 11.0'
	
	# Network
	pod 'Moya', '~> 11.0'
	pod 'Sniffer'
	pod 'Kingfisher'
	
	# Image
	
	# Ui
	pod 'SnapKit', '~> 4.0.0'
	
	# Etc
	pod 'SwiftLint'
	
	
	swift_4_1_targets = []
	
	post_install do |installer|
		print "Setting the default SWIFT_VERSION to 4.2\n"
		installer.pods_project.build_configurations.each do |config|
			config.build_settings['SWIFT_VERSION'] = '4.2'
		end
		
		installer.pods_project.targets.each do |target|
			if swift_4_1_targets.include? "#{target}"
				print "Setting #{target}'s SWIFT_VERSION to 4.1\n"
				target.build_configurations.each do |config|
					config.build_settings['SWIFT_VERSION'] = '3.3'
				end
				else
				print "Setting #{target}'s SWIFT_VERSION to Undefined (Xcode will automatically resolve)\n"
				target.build_configurations.each do |config|
					config.build_settings.delete('SWIFT_VERSION')
					config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
				end
			end
		end
	end
end
