$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopping_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shopping_cart"
  s.version     = ShoppingCart::VERSION
  s.authors     = ["den"]
  s.email       = ["denis.notin@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ShoppingCart."
  s.description = "TODO: Description of ShoppingCart."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5.2"
  s.add_dependency "aasm"
  s.add_dependency 'haml-rails', '0.9.0'
  s.add_dependency 'simple_form'
  s.add_dependency 'country_select'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'haml-rails', '0.9.0'
  s.add_development_dependency 'simple_form'
  s.add_development_dependency 'country_select'
  s.add_development_dependency 'coffee-rails', '~> 4.1.0'
  s.add_development_dependency 'sass-rails', '~> 5.0'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'devise'
  s.add_development_dependency 'byebug'
  s.add_development_dependency "aasm"

end
