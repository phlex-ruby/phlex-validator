# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Img = {
		alt: String,
		attributionsrc: AttributionSource,
		crossorigin: CrossOrigin,
		decoding: Enum(
			:sync,
			:async,
			:auto
		),
		elementtiming: String,
		fetchpriority: FetchPriority,
		height: UInt,
		ismap: _Boolean,
		loading: Enum(
			:eager,
			:lazy
		),
		referrerpolicy: ReferrerPolicy,
		sizes: String, # todo comma-separated list of sizes
		src: Href,
		srcset: String, # todo: comma-separated list
		width: UInt,
		usemap: _String(/^#/),
		align: Deprecated,
		border: Deprecated,
		hspace: Deprecated,
		longdesc: Deprecated,
		name: Deprecated,
		vspace: Deprecated,
	}.freeze
end
