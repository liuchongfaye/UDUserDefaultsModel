Pod::Spec.new do |s|
  s.name         = "NSUserDefaultsModel"
  s.version      = "1.0.1"
  s.summary      = "NSUserDefaultsModel:A library to manager the values saved by NSUserDefaults."
  s.homepage     = "https://github.com/liuchongfaye/NSUserDefaultsModel"
  s.license      = "MIT"
  s.author             = { "刘冲" => "liuchongfaye@163.com" }
  s.source       = { :git => "https://github.com/liuchongfaye/NSUserDefaultsModel.git", :tag => "#{s.version}" }
  s.source_files  = "NSUserDefaultsModel/iOS-Objc/*.{h,m}"
  s.ios.deployment_target = '4.0'
  s.requires_arc = true
end
