# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Ins = {
		cite: Href,
		datetime: DateTimeString,
	}.freeze
end
