# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::A = {
		**Attributes::Global,
		attributionsrc: _Union(_Boolean, Token),
		download: Token,
		href: Href,
		hreflang: Language,
		ping: Tokens,
		referrerpolicy: ReferrerPolicy,
		rel: ARel,
		target: Target,
		type: MimeType,
	}.freeze
end
