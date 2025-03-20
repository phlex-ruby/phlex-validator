# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Col = {
		**Attributes::Global,
		span: UInt,
		align: Deprecated,
		bgcolor: Deprecated,
		char: Deprecated,
		charoff: Deprecated,
		valign: Deprecated,
		width: Deprecated,
	}.freeze
end
