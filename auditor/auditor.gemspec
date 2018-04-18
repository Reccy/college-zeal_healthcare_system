$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "auditor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "auditor"
  s.version     = Auditor::VERSION
  s.authors     = ["Reccy"]
  s.email       = ["aaronmeaney@hotmail.com"]
  s.homepage    = "http://twitter.com/theReccy"
  s.summary     = "Auditing Engine."
  s.description = "Stores and retrieves unmutable audits."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.6"
  s.add_dependency "bootstrap-multiselect_rails", "~> 0.9.4"
  s.add_development_dependency "sqlite3"
end
