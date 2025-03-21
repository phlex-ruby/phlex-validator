# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Area = {
		alt: String,
		# TODO: define coords dynamically
		download: Token,
		href: Href,
		ping: Tokens,
		referrerpolicy: ReferrerPolicy,
		rel: ARel,
		shape: Enum(
			:rect,
			:circle,
			:poly,
			:default
		),
		target: Target,
	}.freeze
end
