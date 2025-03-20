# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Hr = {
		**Attributes::Global,
		align: Deprecated,
		color: Deprecated,
		noshade: Deprecated,
		size: Deprecated,
		width: Deprecated,
	}.freeze
end
