# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Fieldset = {
			disabled: _Boolean,
			form: DOMID,
			name: String,
		}.freeze
end
