# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Form = {
		**Attributes::Global,
		accept: Deprecated,
		accept_charset: String, # TODO: comma-separated list of charsets
		autocomplete: Toggle,
		name: _String(length: 1..), # TODO: must be unique among the form elements in form collection that its in if any
		rel: Tokens, # TODO: eventually this is a space separated list of specific tokens
		action: Href,
		enctype: FormEncoding,
		method: FormMethod,
		novalidate: _Boolean,
		target: Target, # TODO: this may need to be a custom enumeration
	}.freeze
end
