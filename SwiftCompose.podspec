Pod::Spec.new do |s|

    s.platform = :ios
    s.ios.deployment_target = '9.0'
    s.name = "SwiftCompose"
    s.summary = "Composable functions for Swift."
    s.requires_arc = true
    s.version = "1.0.0"
    s.license = { :type => "Apache-2.0", :file => "LICENSE" }
    s.author = { "Hai Pham" => "swiften.svc@gmail.com" }
    s.homepage = "https://github.com/protoman92/SwiftCompose.git"
    s.source = { :git => "https://github.com/protoman92/SwiftCompose.git", :tag => "#{s.version}"}
    s.dependency 'SwiftFP', '~> 1.0.0'

    s.subspec 'Main' do |main|
        main.source_files = "SwiftFP/**/*.{swift}"
    end

end
