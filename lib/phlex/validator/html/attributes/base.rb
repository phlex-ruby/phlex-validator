# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Base = {
		href: Href,
		target: Target, # TODO: verify that this is actually the same target as in other cases
	}.freeze
end
