# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Dialog = {
		**Attributes::Global,
		tabindex: _Never,
		open: _Boolean,
	}.freeze
end
