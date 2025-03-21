# frozen_string_literal: true

module Phlex::Validator::HTML
	# todo: revisit for specific inter-dependent validations
	Attributes::Link = {
		as: Enum(
			:audio,
			:document,
			:embed,
			:fetch,
			:font,
			:image,
			:manifest,
			:object,
			:script,
			:style,
			:track,
			:video,
			:worker,
		),
		blocking: Blocking,
		crossorigin: CrossOrigin,
		disabled: _Boolean,
		fetchpriority: FetchPriority,
		href: Href,
		hreflang: Language,
		imagesizes: String, # todo
		imagesrcset: String, # todo
		integrity: String, # todo
		media: String, # todo — with a CSS parser, you could validate this further
		referrerpolicy: ReferrerPolicy,
		rel: LinkRel, # todo — we can do different validations with internal and externa links
		sizes: Sizes,
		title: String,
		type: MimeType,
		target: _Never,
		charset: Deprecated,
		rev: Deprecated,
	}.freeze
end
