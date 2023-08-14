#
# Be sure to run `pod lib lint VietQRPay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VietQRPay'
  s.version          = '0.0.1'
  s.summary          = 'A short description of VietQRPay.'
  s.description      = 'The library helps to analyze the content from the VietQR code and build the VietQR code from the information provided.'
  s.homepage         = 'https://github.com/quanth1508/VietQRPay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'quanth1508' => 'quanth150820@gmail.com' }
  s.source           = { :git => 'https://github.com/quanth1508/VietQRPay.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'VietQRPay/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VietQRPay' => ['VietQRPay/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
