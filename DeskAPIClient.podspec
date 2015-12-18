Pod::Spec.new do |s|
  s.name         = "DeskAPIClient"
  s.version      = "1.1.3"
  s.summary      = "A lightweight wrapper around the Desk.com API, v2."
  s.license      = { :type => 'BSD 3-Clause', :file => 'LICENSE.txt' }
  s.homepage     = "https://github.com/forcedotcom/DeskApiClient-ObjC"
  s.author       = { "Salesforce, Inc." => "mobile@desk.com" }
  s.source       = { :git => "https://github.com/forcedotcom/DeskApiClient-ObjC.git", :tag => "1.1.3" }
  s.platform     = :ios, '8.0'
  s.source_files = 'DeskAPIClient/DeskAPIClient/*.{h,m}', 'DeskAPIClient/DeskAPIClient/**/*.{h,m}'
  s.requires_arc = true
  s.dependency 'DeskCommon', '~> 1.0.4'
  s.dependency 'DeskCommonTest', '~> 1.0.2'
  s.dependency 'Expecta', '~> 0.3.1'
  s.dependency 'OCMock', '~> 3.0.2'
end
