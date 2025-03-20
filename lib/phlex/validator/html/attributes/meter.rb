# frozen_string_literal: true

module Phlex::Validator::HTML
	# TODO: We should verify things like min < max, etc.
	Attributes::Meter = {
		**Attributes::Global,
		value: NumericValue,
		min: NumericValue,
		max: NumericValue,
		low: NumericValue,
		high: NumericValue,
		optimum: NumericValue,
		form: DOMID,
	}.freeze
end
