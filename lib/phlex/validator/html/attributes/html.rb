# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::HTML = {
		**Attributes::Global,
		version: Deprecated,
		xmlns: String,
	}.freeze
end
