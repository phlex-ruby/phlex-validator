# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Style = {
		blocking: Blocking,
		media: String,
		nonce: String,
		title: String,
		type: Deprecated,
	}.freeze
end
