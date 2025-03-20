# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Br = {
		**Attributes::Global,
		clear: Deprecated,
	}.freeze
end
