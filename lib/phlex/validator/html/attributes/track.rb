# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Track = {
		default: _Boolean,
		kind: Enum(:subtitles, :captions, :chapters, :metadata),
		label: String,
		src: Href,
		srclang: BCP47Language,
	}.freeze
end
