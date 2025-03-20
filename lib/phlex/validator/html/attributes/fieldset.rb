# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Fieldset = {
			**Attributes::Global,
			disabled: _Boolean,
			form: DOMID,
			name: String,
		}.freeze
end
