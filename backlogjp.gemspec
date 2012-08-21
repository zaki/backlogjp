# -*- encoding: utf-8 -*-
require File.expand_path('../lib/backlogjp/_version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Zoltan Dezso"]
  gem.email         = ["dezso.zoltan@gmail.com"]
  gem.description   = %q{A wrapper for the backlog.jp API}
  gem.summary       = %q{A wrapper for the backlog.jp API}
  gem.homepage      = "http://github.com/zaki/backlogjp"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "backlogjp"
  gem.require_paths = ["lib"]
  gem.version       = Backlogjp::VERSION

  gem.add_development_dependency('rspec')
end
