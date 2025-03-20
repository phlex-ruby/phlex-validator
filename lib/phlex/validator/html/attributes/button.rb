# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Button = {
		**Attributes::Global,
		autofocus: _Boolean,
		command: _Union(
			Enum(
				:show_modal,
				:close,
				:request_close,
				:show_popover,
				:hide_popover,
				:toggle_popover,
			),
			_String(/\A--/),
		),
		commandfor: DOMID,
		disabled: _Boolean,
		form: DOMID,
		formaction: Href,
		formenctype: FormEncoding,
		formmethod: FormMethod,
		formnovalidate: _Boolean,
		formtarget: Target, # TODO: verify this is actually the same target
		name: String,
		popovertarget: DOMID,
		popovertargetaction: PopoverTargetAction,
		type: Enum(
			:submit,
			:reset,
			:button
		),
		value: String,
	}.freeze
end
