# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Dfn = {
		**Attributes::Global,
		title: String,
	}.freeze
end
