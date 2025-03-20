# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Iframe = {
		**Attributes::Global,
		allow: String,
		allowfullscreen: Deprecated,
		allowpaymentrequest: Deprecated,
		browsingtopics: _Boolean,
		credentialless: _Boolean,
		csp: String, # TODO: improve this
		height: UInt,
		loading: Enum(
			"eager",
			"lazy"
		),
		name: String,
		referrerpolicy: ReferrerPolicy, # TODO: improve this
		sandbox: Enum(
			"allow-downloads",
			"allow-forms",
			"allow-modals",
			"allow-orientation-lock",
			"allow-pointer-lock",
			"allow-popups",
			"allow-popups-to-escape-sandbox",
			"allow-presentation",
			"allow-same-origin",
			"allow-scripts",
			"allow-storage-access-by-user-activation",
			"allow-top-navigation",
			"allow-top-navigation-by-user-activation",
			"allow-top-navigation-to-custom-protocols"
		),
		src: Href,
		srcdoc: Phlex::HTML::SafeObject,
		width: UInt,
		align: Deprecated,
		frameborder: Deprecated,
		longdesc: Deprecated,
		marginheight: Deprecated,
		marginwidth: Deprecated,
		scrolling: Deprecated,
	}.freeze
end
