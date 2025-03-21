# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Template = {
		shadowrootmode: Hatch,
		shadowrootclonable: _Boolean,
		shadowrootdelegatesfocus: _Boolean,
		shadowrootserializable: _Boolean,
	}.freeze
end
