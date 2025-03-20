# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Global = {
		accesskey: Tokens,
		autocapitalize: Enum(
			"on",
			"off",
			"none",
			"sentences",
			"words",
			"characters"
		),
		autocorrect: Token,
		autofocus: _Boolean,
		class: Tokens,
		contenteditable: Enum(
			"true",
			"false",
			"plaintext-only"
		),
		dir: _Union(
			Token("auto"),
			TextDirection,
		),
		draggable: EnumeratedBoolean,
		enterkeyhint: Enum(
			"enter",
			"done",
			"go",
			"next",
			"previous",
			"search",
			"send"
		),
		exportparts: String, # TODO: investigate updating Phlex to comma-separate tokens passed to this attribute
		hidden: _Union(
			_Boolean,
			Enum(
				"hidden",
				"until-found"
			)
		),
		id: DOMID,
		inert: _Boolean,
		inputmode: InputMode,
		is: Token,
		itemid: Token,
		itemprop: Token,
		itemref: Tokens,
		itemscope: _Boolean,
		itemtype: Token,
		lang: Language,
		nonce: Token,
		part: Token,
		popover: _Union(
			_Boolean,
			Enum(
				"auto",
				"hint",
				"manual"
			)
		),
		slot: Token,
		spellcheck: EnumeratedBoolean,
		# TODO: figure out style
		tabindex: Integer,
		title: String,
		translate: Affirmation,
		virtualkeyboardpolicy: Enum("auto", "manual"),
		writingsuggestions: EnumeratedBoolean,
	}.freeze
end
