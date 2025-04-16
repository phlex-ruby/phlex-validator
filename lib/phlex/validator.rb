# frozen_string_literal: true

require "zeitwerk"
require "phlex"
require "literal"
require "uri"
require "phlex/validator/version"

module Phlex::Validator
	Loader = Zeitwerk::Loader.for_gem_extension(Phlex).tap do |loader|
		loader.inflector = Zeitwerk::NullInflector.new
		loader.setup
	end
end
