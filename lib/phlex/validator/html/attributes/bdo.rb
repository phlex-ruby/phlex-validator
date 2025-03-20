# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Bdo = {
		**Attributes::Global,
		dir: TextDirection,
	}.freeze
end
