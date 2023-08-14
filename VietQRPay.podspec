Pod::Spec.new do |s|
  s.name             = 'VietQRPay'
  s.version          = '0.0.1'
  s.summary          = 'VietQRPay is the library support an iOS development.'
  s.description      = 'The library helps to analyze the content from the VietQR code and build the VietQR code from the information provided.'
  s.homepage         = 'https://github.com/quanth1508/VietQRPay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'quanth1508' => 'quanth150820@gmail.com' }
  s.source           = { :git => 'https://github.com/quanth1508/VietQRPay.git', :tag => s.version.to_s }
  s.frameworks       = "Foundation"
  s.swift_version    = "5.0"
  s.ios.deployment_target = '11.0'
  s.source_files     = 'Sources/*'
end
