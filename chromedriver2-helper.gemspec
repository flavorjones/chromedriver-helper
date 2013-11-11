# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "chromedriver2/helper/version"

Gem::Specification.new do |s|
  s.name        = "chromedriver2-helper"
  s.version     = Chromedriver::Helper::VERSION
  s.authors     = ["Mike Dalessio","Zsolt Sztupak"]
  s.email       = ["mike@csa.net","mail@sztupy.hu"]
  s.homepage    = "https://github.com/sztupy/chromedriver-helper"
  s.summary     = "Easy installation and use of chromedriver2, the Chromium project's selenium webdriver adapter."
  s.description = "Downloads and installs chromedriver2 from google's page and uses it for running the selenium tests. Contains fixes for mac builds, and changes to the google URLs"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_runtime_dependency "nokogiri"
end
