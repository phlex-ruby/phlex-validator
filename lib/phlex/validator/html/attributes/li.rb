# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Li = {
		**Attributes::Global,
		value: Integer,
		type: Deprecated,
	}.freeze
end
