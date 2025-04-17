# frozen_string_literal: true

if ENV["COVERAGE"] == "true"
	require "simplecov"

	SimpleCov.start do
		command_name "quickdraw"
		enable_coverage_for_eval
		enable_for_subprocesses true
		enable_coverage :branch
	end
end

Bundler.require :test

require "phlex-validator"

Phlex::Validator::Loader.eager_load

# Previous content of test helper now starts here
$LOAD_PATH.unshift(File.expand_path("../fixtures", __dir__))

class Quickdraw::Test
	def refute_valid_html(&block)
		assert_raises TypeError do
			phlex(&block)
		end
	end

	def assert_valid_html(&)
		phlex(&)
		success!
	end

	class Example < Phlex::HTML
		include Phlex::Validator::HTML::Mixin
	end

	def phlex(&block)
		Example.call do |component|
			receiver = block.binding.receiver

			receiver.instance_variables.each do |ivar|
				next if component.instance_variable_defined?(ivar)

				value = receiver.instance_variable_get(ivar)
				component.instance_variable_set(ivar, value)
			end

			component.instance_exec(receiver, &block)
		end
	end
end
