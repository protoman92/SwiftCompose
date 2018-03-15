# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def allPods
    pod 'SwiftFP/Main', git: 'https://github.com/protoman92/SwiftFP.git'
end

target 'SwiftCompose' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  allPods

  # Pods for SwiftCompose

  target 'SwiftComposeTests' do
    inherit! :search_paths
    # Pods for testing
    allPods
  end

end
