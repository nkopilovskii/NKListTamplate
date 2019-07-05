#
# Be sure to run `pod lib lint NKListTamplate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NKListTamplate'
  s.version          = '0.1.0'
  s.summary          = 'Tool for quick and compact UITableView configuration.'
  s.description      = <<-DESC
  The solution is a template with the implementation of the basic methods of configuration and table management; uses the configuration mechanism of individual views NKAnyViewModel.
  
  The solution is designed for multi-level architectures, as it allows to distribute the code into the corresponding layers of the module.
                       DESC

  s.homepage         = 'https://github.com/nkopilovskii/NKListTamplate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nick Kopilovskii' => 'nkopilovskii@gmail.com' }
  s.source           = { :git => 'https://github.com/nkopilovskii/NKListTamplate.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mkopilovskii'

  s.ios.deployment_target = '10.0'

  s.source_files = 'NKListTamplate/Classes/**/*'

   s.dependency 'NKAnyViewModel', '~> 0.1.0.1'
end
