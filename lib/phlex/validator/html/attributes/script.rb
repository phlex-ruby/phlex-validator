# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Script = {
		async: _Boolean,
		attributionsrc: AttributionSource,
		blocking: Blocking,
		crossorigin: CrossOrigin,
		defer: _Boolean,
		fetchpriority: FetchPriority,
		integrity: String, # TODO: maybe this can be validated
		nomodule: _Boolean,
		nonce: String,
		referrerpolicy: ReferrerPolicy,
		src: Href,
		type: Enum(
			:importmap,
			:module,
			:speculationrules,
		),
		charset: Deprecated,
		language: Deprecated,
	}.freeze
end
