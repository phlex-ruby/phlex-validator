# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Div = {
		**Attributes::Global,
		align: Deprecated,
	}.freeze
end
