# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Th = {
		abbr: String,
		colspan: ColSpan,
		headers: SpaceSeparatedList(DOMID),
		rowspan: RowSpan,
		scope: Enum(
			:row,
			:col,
			:rowgroup,
			:colgroup
		),
		align: Deprecated,
		axis: Deprecated,
		bgcolor: Deprecated,
		char: Deprecated,
		charoff: Deprecated,
		height: Deprecated,
		valign: Deprecated,
		width: Deprecated,
	}.freeze
end
