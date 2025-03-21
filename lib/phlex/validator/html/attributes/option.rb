# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Option = {
		disabled: _Boolean,
		label: String,
		selected: _Boolean,
		value: String,
	}.freeze
end
