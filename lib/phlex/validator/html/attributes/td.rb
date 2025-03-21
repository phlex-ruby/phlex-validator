# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Td = {
		colspan: _Integer(0..1000),
		headers: SpaceSeparatedList(DOMID),
		rowspan: _Integer(0..65534),
		abbr: Deprecated,
		align: Deprecated,
		axis: Deprecated,
		bgcolor: Deprecated,
		char: Deprecated,
		charoff: Deprecated,
		height: Deprecated,
		scope: Deprecated,
		valign: Deprecated,
		width: Deprecated,
	}.freeze
end
