# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Ol = {
		reversed: _Boolean,
		start: UInt,
		type: _Union(
			1,
			"a",
			"A",
			"i",
			"I"
		),
	}.freeze
end
