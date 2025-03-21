# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Textarea = {
		autocomplete: Autocomplete,
		cols: PositiveInteger,
		dirname: TextDirection,
		disabled: _Boolean,
		form: DOMID,
		maxlength: UInt,
		minlength: UInt,
		name: String,
		placeholder: String,
		readonly: _Boolean,
		required: _Boolean,
		rows: PositiveInteger,
		spellcheck: Enum(:true, :false, :default),
		wrap: Enum(:hard, :soft),
	}
end
