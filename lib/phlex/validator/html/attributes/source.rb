# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Source = {
		type: MimeType,
		src: Href,
		srcset: String, # todo
		sizes: Sizes,
		media: String,
		height: UInt,
		width: UInt,
	}.freeze
end
