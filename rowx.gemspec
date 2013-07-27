Gem::Specification.new do |s|
  s.name = 'rowx'
  s.version = '0.1.4'
  s.summary = 'rowx'
  s.description = 'Generates XML from rows of labelled, nested, and plain text' 
    s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('line-tree')
  s.add_dependency('rexle') 
  s.signing_key = '../privatekeys/rowx.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/rowx'
end
