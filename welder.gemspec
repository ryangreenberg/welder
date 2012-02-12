# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "welder/version"

Gem::Specification.new do |s|
  s.name        = "welder"
  s.version     = Welder::VERSION
  s.authors     = ["Ryan Greenberg"]
  s.email       = ["ryangreenberg@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{An implementation of the iOS game W.E.L.D.E.R.}
  s.description = s.summary

  s.rubyforge_project = "welder"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.8.0"
end
