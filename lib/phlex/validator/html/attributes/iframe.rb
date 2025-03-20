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
			:eager,
			:lazy
		),
		name: String,
		referrerpolicy: ReferrerPolicy, # TODO: improve this
		sandbox: Enum(
			:allow_downloads,
			:allow_forms,
			:allow_modals,
			:allow_orientation_lock,
			:allow_pointer_lock,
			:allow_popups,
			:allow_popups_to_escape_sandbox,
			:allow_presentation,
			:allow_same_origin,
			:allow_scripts,
			:allow_storage_access_by_user_activation,
			:allow_top_navigation,
			:allow_top_navigation_by_user_activation,
			:allow_top_navigation_to_custom_protocols
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
