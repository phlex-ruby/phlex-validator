# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Ins = {
		**Attributes::Global,
		cite: Href,
		datetime: DateTimeString,
	}.freeze
end
