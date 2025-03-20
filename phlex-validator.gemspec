# frozen_string_literal: true

require_relative "lib/phlex/validator/version"

Gem::Specification.new do |spec|
	spec.name = "phlex-validator"
	spec.version = Phlex::Validator::VERSION
	spec.authors = ["Joel Drapper"]
	spec.email = ["joel@drapper.me"]

	spec.summary = "Strict Phlex validation"
	spec.homepage = "https://github.com/phlex-ruby/phlex-validator"
	spec.license = "MIT"
	spec.required_ruby_version = ">= 3.2"

	spec.metadata["homepage_uri"] = spec.homepage
	spec.metadata["source_code_uri"] = "https://github.com/phlex-ruby/phlex-validator"
	spec.metadata["changelog_uri"] = "https://github.com/phlex-ruby/phlex-validator/releases"
	spec.metadata["funding_uri"] = "https://github.com/sponsors/joeldrapper"
	spec.metadata["rubygems_mfa_required"] = "true"

	spec.files = Dir[
		"README.md",
		"LICENSE.txt",
		"lib/**/*.rb"
	]

	spec.add_dependency "zeitwerk", "~> 2"
	spec.add_dependency "phlex", "~> 2"
	spec.add_dependency "literal", "~> 1"

	spec.require_paths = ["lib"]
end
