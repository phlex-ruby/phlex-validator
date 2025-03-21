# frozen_string_literal: true

module Phlex::Validator::HTML
	# TODO: We can validate the content based on the http_equiv value
	Attributes::Meta = {
		charset: Token(:utf_8),
		content: String,
		http_equiv: Enum(
			:content_security_policy,
			:content_type,
			:default_style,
			:x_ua_compatible,
			:refresh
		),
		media: String,
		name: String,
	}.freeze
end
