# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Select = {
		autocomplete: Autocomplete,
		autofocus: _Boolean,
		disabled: _Boolean,
		form: DOMID,
		multiple: _Boolean,
		name: String,
		required: _Boolean,
		size: UInt,
	}.freeze
end
