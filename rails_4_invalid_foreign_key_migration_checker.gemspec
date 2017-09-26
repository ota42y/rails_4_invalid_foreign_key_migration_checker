# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_4_invalid_foreign_key_migration_checker/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_4_invalid_foreign_key_migration_checker"
  spec.version       = Rails4InvalidForeignKeyMigrationChecker::VERSION
  spec.authors       = ["ota42y"]
  spec.email         = ["ota42y@gmail.com"]

  spec.summary       = 'check invalid foreign key migration'
  spec.description   = 'when there are users table and posts table, "remove_foreign_key :users, :post" is invalid migration but rails 4 not raise error and rails 5 raise error this gem check it'
  spec.homepage      = "https://github.com/ota42y/rails_4_invalid_foreign_key_migration_checker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", "< 5.0"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
