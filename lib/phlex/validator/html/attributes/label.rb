# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Label = {
		**Attributes::Global,
		for: DOMID,
	}.freeze
end
