# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Td = {
		colspan: ColSpan,
		headers: SpaceSeparatedList(DOMID),
		rowspan: RowSpan,
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
