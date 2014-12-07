Pod::Spec.new do |s|
  s.name = "NorwegianSSN"
  s.version = "1.0"
  s.summary = "A convenient way of validating and extracting info from a Norwegian Social Security Number"
  s.description = <<-DESC
                   * A convenient way of validating and extracting info from a Norwegian Social Security Number
                   DESC
  s.homepage = "https://github.com/hyperoslo/NorwegianSSN"
  s.license = {
    :type => 'MIT',
    :file => 'LICENSE.md'
  }
  s.author = { "Hyper Interaktiv" => "teknologi@hyper.no" }
  s.social_media_url = "https://twitter.com/hyperoslo"
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.10'
  s.source = {
    :git => 'https://github.com/hyperoslo/NorwegianSSN.git',
    :tag => s.version.to_s
  }
  s.source_files = 'Source/*.*'
  s.frameworks = 'Foundation'
  s.requires_arc = true
end
