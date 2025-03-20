# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Canvas = {
		**Attributes::Global,
		height: Integer,
		width: Integer,
	}.freeze
end
