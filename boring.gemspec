require_relative './lib/version'

Gem::Specification.new do |s|
  s.name        = 'boring'
  s.version     = '0.1.0'
  s.authors     = ['Adam Sanderson']
  s.email       = ['netghost@gmail.com']
  s.homepage    = 'https://github.com/adamsanderson/boring'
  
  s.summary     = 'Strip ANSI escape sequences.'
  s.description = 'Shake free the shackles of color; resist the tyranny of fun! Easily strips ANSI escape sequences.'

  s.files        = Dir.glob('{bin,lib}/**/*') + ["README.markdown"]
  s.executable   = 'boring'
  s.require_path = 'lib'
end