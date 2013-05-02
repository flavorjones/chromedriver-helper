# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "chromedriver2/helper/version"

Gem::Specification.new do |s|
  s.name        = "chromedriver2-helper"
  s.version     = Chromedriver::Helper::VERSION
  s.authors     = ["Mike Dalessio"]
  s.email       = ["mike@csa.net"]
  s.homepage    = ""
  s.summary     = "Easy installation and use of chromedriver2, the Chromium project's selenium webdriver adapter."
  s.description = "Easy installation and use of chromedriver2, the Chromium project's selenium webdriver adapter."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_runtime_dependency "nokogiri"
end
