# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Progress = {
		value: PositiveNumeric,
		max: PositiveNumeric,
	}.freeze
end
