Pod::Spec.new do |s|
  s.name             = "SocaCore"
  s.version          = "0.4.1"
  s.summary          = "The core of Soca."
  s.description      = <<-DESC
                       Things backing up Soca.
                       DESC
  s.homepage         = "https://github.com/zhuhaow/SocaCore"
  s.license          = 'MIT'
  s.author           = { "Zhuhao Wang" => "zhuhaow@gmail.com" }
  s.source           = { :git => "https://github.com/zhuhaow/SocaCore.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m,swift}'
  s.resources = ['Pod/Classes/*.xcdatamodeld', 'pod/Classes/*.mobileconfig', 'pod/Classes/GeoIP.dat']

  s.frameworks = 'Foundation', 'CoreData'
  s.dependency 'SocaCrypto', '~> 0.1.0'
  s.dependency 'XCGLogger', '~> 2.0.0'
  s.dependency 'MagicalRecord', '~> 2.2.0'
end
