# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Body = {
		onafterprint: JavaScript,
		onbeforeprint: JavaScript,
		onbeforeunload: JavaScript,
		onblur: JavaScript,
		onerror: JavaScript,
		onfocus: JavaScript,
		onhashchange: JavaScript,
		onlanguagechange: JavaScript,
		onload: JavaScript,
		onmessage: JavaScript,
		onmessageerror: JavaScript,
		onoffline: JavaScript,
		ononline: JavaScript,
		onpageswap: JavaScript,
		onpagehide: JavaScript,
		onpagereveal: JavaScript,
		onpageshow: JavaScript,
		onpopstate: JavaScript,
		onresize: JavaScript,
		onrejectionhandled: JavaScript,
		onstorage: JavaScript,
		onunhandledrejection: JavaScript,
		onunload: JavaScript,
		alink: Deprecated,
		background: Deprecated,
		bgcolor: Deprecated,
		bottommargin: Deprecated,
		leftmargin: Deprecated,
		link: Deprecated,
		rightmargin: Deprecated,
		text: Deprecated,
		topmargin: Deprecated,
		vlink: Deprecated,
	}.freeze
end
