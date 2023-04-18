require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
use_hermes = ENV['USE_HERMES'] == '1'

Pod::Spec.new do |s|
  s.name         = "react-native-mmkv"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "11.0", :tvos => "12.0", :osx => "10.14" }
  s.source       = { :git => "https://github.com/mrousavy/react-native-mmkv.git", :tag => "#{s.version}" }

  # All source files that should be publicly visible
  # Note how this does not include headers, since those can nameclash.
  s.source_files = [
    "ios/**/*.{m,mm}",
    "ios/MmkvModule.h",
    "cpp/**/*.{h,cpp}"
  ]
  # Any private headers that are not globally unique should be mentioned here.
  # Otherwise there will be a nameclash, since CocoaPods flattens out any header directories
  # See https://github.com/firebase/firebase-ios-sdk/issues/4035 for more details.
  s.preserve_paths = [
    'ios/**/*.h'
  ]
  
  if use_hermes
    s.dependency 'React-hermes'
    s.dependency 'hermes-engine'
  else
    s.dependency 'React-jsc'
  end
  s.dependency "MMKV", ">= 1.2.13"
  s.dependency "React-Core"
end
