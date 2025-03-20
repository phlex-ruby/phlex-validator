# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Blockquote = {
		**Attributes::Global,
		cite: Href,
	}.freeze
end
