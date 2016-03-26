Gem::Specification.new do |s|
  s.name = 'rowx'
  s.version = '0.5.0'
  s.summary = 'rowx'
  s.description = 'Generates XML from rows of labelled text, nested text, and plain text' 
  s.authors = ['James Robertson']
  s.files = Dir['lib/rowx.rb']
  s.add_runtime_dependency('line-tree', '~> 0.5', '>=0.5.6')
  s.signing_key = '../privatekeys/rowx.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/rowx'
  s.required_ruby_version = '>= 2.1.2'
end
