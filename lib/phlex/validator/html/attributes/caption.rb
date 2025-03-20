# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Caption = {
		**Attributes::Global,
		align: Deprecated,
	}.freeze
end
