# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Audio = {
		**Attributes::Global,
		autoplay: {
			type: _Boolean,
			link: "https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio#autoplay",
		},
		controls: _Boolean,
		controlslist: ControlsList,
		crossorigin: CrossOrigin,
		disableremoteplayback: _Boolean,
		loop: _Boolean,
		muted: _Boolean,
		preload: Enum(
			"none",
			"metadata",
			"auto"
		),
		src: String,
	}.freeze
end
