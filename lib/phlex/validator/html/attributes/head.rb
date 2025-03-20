# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Head = {
		**Attributes::Global,
		profile: Tokens, # TODO: improve this
	}.freeze
end
