# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Details = {
		**Attributes::Global,
		open: _Boolean,
		name: String,
	}.freeze
end
