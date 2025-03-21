# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Del = {
		cite: Href,
		datetime: DateTimeString,
	}.freeze
end
