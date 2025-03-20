# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Fencedframe = {
		**Attributes::Global,
		allow: String,
		height: UInt,
		width: UInt,
	}.freeze
end
