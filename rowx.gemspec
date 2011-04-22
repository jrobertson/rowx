Gem::Specification.new do |s|
  s.name = 'rowx'
  s.version = '0.1.1'
  s.summary = 'rowx'
  s.description = 'Generates XML from rows of labelled, nested, and plain text' 
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('line-tree')
  s.add_dependency('rexle')
end
