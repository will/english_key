require File.dirname(__FILE__) + '/lib/english_key'
require 'date'

Gem::Specification.new do |s|
  s.name          = 'english_key'
  s.version       = EnglishKey::VERSION
  s.date          = Date.today.to_s
  s.authors       = 'Will Leinweber'
  s.email         = 'will@bitfission.com'
  s.summary       = 'RFC1751 for Ruby'
  s.description   = 'RFC1751 for Ruby. A Convention for Human-Readable 128-bit Keys'
  s.homepage      = 'http://github.com/will/english_key'
  s.files         =  Dir.glob('lib/**/*') + ['Readme.md', 'License']
  s.require_paths = ['lib']

  s.add_development_dependency('rspec', ['~> 2'])
end

