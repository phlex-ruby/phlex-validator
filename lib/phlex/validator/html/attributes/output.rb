# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Output = {
		for: SpaceSeparatedList(DOMID),
		form: DOMID,
		name: String,
	}.freeze
end
