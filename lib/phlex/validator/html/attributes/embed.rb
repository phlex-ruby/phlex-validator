# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Embed = {
		height: UInt,
		src: Href,
		type: MimeType,
		width: UInt,
	}.freeze
end
