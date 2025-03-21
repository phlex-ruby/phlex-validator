# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Video = {
		autoplay: _Boolean,
		controls: _Boolean,
		controlslist: Enum(:nodownload, :nofullscreen, :noremoteplayback),
		crossorigin: CrossOrigin,
		disablepictureinpicture: _Boolean,
		disableremoteplayback: _Boolean,
		height: UInt,
		loop: _Boolean,
		muted: _Boolean,
		playsinline: _Boolean,
		poster: Href,
		preload: Enum(:none, :metadata, :auto),
		src: Href,
		width: UInt,
	}.freeze
end
