# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Object = {
		archive: Deprecated,
		border: Deprecated,
		classid: Deprecated,
		codebase: Deprecated,
		codetype: Deprecated,
		data: Href,
		declare: Deprecated,
		form: DOMID,
		height: UInt,
		name: String,
		standby: Deprecated,
		type: String, # TODO: should this be an enum?
		usemap: Deprecated,
		width: UInt,
	}.freeze
end
