$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'jaimito/version'

Gem::Specification.new do |s|
  s.name        = 'jaimito'
  s.version     = Jaimito::VERSION
  s.description = ""
  s.summary     = ""
  s.authors     = ["Thiago Porto", "Hideki Matsumoto"]
  s.homepage    = 'https://github.com/Vizir/jaimito'
  s.files       = `git ls-files`.split("\n")
  s.licenses    = ["MIT license (MIT)"]

  s.add_dependency 'sanitize', '> 3.0.0'
  s.add_dependency 'rails', '~> 4.2.0'

  s.add_development_dependency 'rspec-rails', '~> 3.4.2'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'sqlite3'
end
