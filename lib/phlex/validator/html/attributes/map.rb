# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Map = {
		**Attributes::Global,
		name: String,
	}.freeze
end
