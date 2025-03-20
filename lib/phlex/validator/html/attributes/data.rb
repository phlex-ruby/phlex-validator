# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Data = {
		**Attributes::Global,
		value: Value,
	}.freeze
end
