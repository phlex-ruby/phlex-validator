# frozen_string_literal: true

# TODO: Only one element in the document can have the `autofocus` attribute.

module Phlex::Validator::HTML
	extend Literal::Types

	def self.Token(symbol)
		_Union(symbol, symbol.name.tr("_", "-"))
	end

	def self.Enum(*tokens)
		_Union(*tokens, *tokens.map { |it| it.name.tr("_", "-") })
	end

	def self.SpaceSeparatedList(type)
		_Union(
			type,
			_Array(type),
			_String(-> (it) { it.split(/\s+/).all?(type) })
		)
	end

	def self.CommaSeparatedList(type)
		_Union(
			type,
			# _Array(type), # TODO: we can re-introduce this once Phlex supports it
			_String(-> (it) { it.split(/\s*,\s*/).all?(type) })
		)
	end

	def self.Pattern(regex, &block)
		raise ArgumentError "Block required for Pattern" unless block

		-> (value) {
			if (data = regex.match(value))
				!!block.call(*data.captures, **data.named_captures&.transform_keys(&:to_sym))
			else
				false
			end
		}
	end

	BCP47Language = _Union(
		"ar-SA",
		"bn-BD",
		"bn-IN",
		"cs-CZ",
		"da-DK",
		"de-AT",
		"de-CH",
		"de-DE",
		"el-GR",
		"en-AU",
		"en-CA",
		"en-GB",
		"en-IE",
		"en-IN",
		"en-NZ",
		"en-US",
		"en-ZA",
		"es-AR",
		"es-CL",
		"es-CO",
		"es-ES",
		"es-MX",
		"es-US",
		"fi-FI",
		"fr-BE",
		"fr-CA",
		"fr-CH",
		"fr-FR",
		"he-IL",
		"hi-IN",
		"hu-HU",
		"id-ID",
		"it-CH",
		"it-IT",
		"ja-JP",
		"ko-KR",
		"nl-BE",
		"nl-NL",
		"no-NO",
		"pl-PL",
		"pt-BR",
		"pt-PT",
		"ro-RO",
		"ru-RU",
		"sk-SK",
		"sv-SE",
		"ta-IN",
		"ta-LK",
		"th-TH",
		"tr-TR",
		"zh-CN",
		"zh-HK",
		"zh-T",
	)

	# Any attribute allowed by Phlex
	Attribute = _Union(
		nil,
		true,
		false,
		String,
		Symbol,
		Integer,
		Float,
		_Array(
			_Deferred { Attribute }
		),
		_Hash(
			_Union(String, Symbol),
			_Deferred { Attribute }
		)
	)

	# Like Attribute, but excluding Hashes, which in most cases define other attributes
	Value = _Union(
		nil,
		true,
		false,
		String,
		Symbol,
		Integer,
		Float,
		Array(
			_Deferred { Value }
		)
	)

	# YYYY
	SPECIFIC_YEAR = /(?<yyyy>\d{4,})/

	# MM
	ABSTRACT_MONTH = /(?<mm>(?:0[1-9]|1[0-2]))/

	# WW
	ABSTRACT_WEEK = /(?<ww>(?:0[1-9]|[1-4]\d|5[0-3]))/

	# DD
	ABSTRACT_DAY = /(?<dd>(?:0[1-9]|[1-2]\d|3[0-1]))/

	# YYYY-MM
	SPECIFIC_MONTH = /#{SPECIFIC_YEAR}-#{ABSTRACT_MONTH}/

	# YYYY-WWW
	SPECIFIC_WEEK = /#{SPECIFIC_YEAR}-W#{ABSTRACT_WEEK}/

	# YYYY-MM-DD
	SPECIFIC_DATE = /#{SPECIFIC_YEAR}-#{ABSTRACT_MONTH}-#{ABSTRACT_DAY}/

	# MM-DD
	ABSTRACT_DAY_OF_MONTH = /#{ABSTRACT_MONTH}-#{ABSTRACT_DAY}/

	# HH
	ABSTRACT_HOUR = /(?<h>([0-1]\d|2[0-3]))/

	# MM
	ABSTRACT_MINUTE = /(?<m>([0-5]\d))/

	# SS
	ABSTRACT_SECOND = /(?<s>([0-5]\d))/

	# mmm
	ABSTRACT_MILLISECOND = /(?<ms>(?:\d{3}))/

	# HH:MM(:SS(.mmm))
	ABSTRACT_TIME = /#{ABSTRACT_HOUR}:#{ABSTRACT_MINUTE}(?::#{ABSTRACT_SECOND}(?:\.#{ABSTRACT_MILLISECOND})?)?/

	# +HHMM | -HHMM | +HH:MM | -HH:MM
	TIME_ZONE_OFFSET = /(?:Z|(?:\+|-)(?:[0-1][0-9]|2[0-3]):?(?:[0-5][0-9]))/

	# YYYY-MM-DDTHH:MM(:SS(.mmm)) | YYYY-MM-DD HH:MM(:SS(.mmm))
	SPECIFIC_LOCAL_DATE_TIME = /#{SPECIFIC_DATE}(?:T| )#{ABSTRACT_TIME}/

	# YYYY-MM-DDTHH:MM(:SS(.mmm))Z | YYYY-MM-DD HH:MM(:SS(.mmm))Z
	SPECIFIC_DATE_TIME = /#{SPECIFIC_DATE}(?:T| )#{ABSTRACT_TIME}#{TIME_ZONE_OFFSET}/

	# DDd HHh MMm SSs
	INFORMAL_DURATION = /\A(?:(\d+d)(?: (\d+h))?(?: (\d+m))?(?: (\d+s))?|(\d+h)(?: (\d+m))?(?: (\d+s))?|(\d+m)(?: (\d+s))?|(\d+s))?\z/

	# PdDThHmMsS
	PERIOD = /P(?<d>\d+D)?T(?<h>\d+H)?(?<m>\d+M)?(?<s>\d+(?:\.\d{1,3})?S)/

	AbstractTime = _String(/\A#{ABSTRACT_TIME}\z/)

	YearString = _String(
		Pattern(/\A#{SPECIFIC_YEAR}\z/) { |yyyy:|
			yyyy.to_i > 0
		}
	)

	WeekString = _String(
		Pattern(SPECIFIC_WEEK) { |yyyy:, ww:|
			year, week = yyyy.to_i, ww.to_i

			next false unless year > 0

			if week <= 52
				true
			else
				first_day_of_year = (1 + (5 * ((year - 1) % 4)) + (4 * ((year - 1) % 100)) + (6 * ((year - 1) % 400))) % 7

				first_day_of_year == 4 || (first_day_of_year == 3 && leap_year?(year))
			end
		}
	)

	MonthString = _String(
		Pattern(/\A#{SPECIFIC_MONTH}\z/) { |yyyy:, mm:|
			year, month = yyyy.to_i, mm.to_i

			year > 0
		}
	)

	MONTH_LENGTHS = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31].freeze

	AbstractDayOfMonth = Pattern(/\A#{ABSTRACT_DAY_OF_MONTH}\z/) do |mm:, dd:|
		month, day = mm.to_i, dd.to_i
		day <= MONTH_LENGTHS[month] || (month == 2 && day == 29)
	end

	def self.leap_year?(year) = year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)

	def self.valid_date?(year, month, day)
		day <= MONTH_LENGTHS[month] || (
			month == 2 && day == 29 && leap_year?(year)
		)
	end

	DateString = _String(
		Pattern(/\A#{SPECIFIC_DATE}\z/) { |yyyy:, mm:, dd:|
			valid_date?(yyyy.to_i, mm.to_i, dd.to_i)
		}
	)

	LocalDateTimeString = _String(
		Pattern(/\A#{SPECIFIC_LOCAL_DATE_TIME}\z/) { |yyyy:, mm:, dd:, **|
			valid_date?(yyyy.to_i, mm.to_i, dd.to_i)
		}
	)

	DateTimeString = _String(
		Pattern(/\A#{SPECIFIC_DATE_TIME}\z/) { |yyyy:, mm:, dd:, **|
			valid_date?(yyyy.to_i, mm.to_i, dd.to_i)
		}
	)

	DurationString = _String(/\A#{INFORMAL_DURATION}\z/)
	PeriodString = _String(/\A#{PERIOD}\z/)

	TimeString = _String(/\A([01][0-9]|2[0-3]):([0-5][0-9])(:[0-5][0-9](\.\d{1,3})?)?\z/)

	TimeZoneOffset = _String(/\A#{TIME_ZONE_OFFSET}\z/)

	Deprecated = _Never
	JavaScript = Phlex::HTML::SafeObject
	EmailAddressString = _String(URI::MailTo::EMAIL_REGEXP)
	NumericString = _String(/\A-?(\d+(\.\d*)?|\.\d+)\z/)
	NumericValue = _Union(Integer, Float, NumericString)

	# An integer or float that’s greater than zero
	PositiveInteger = _Integer(1..)
	PositiveFloat = _Float(0.., _Not(0.0))
	PositiveNumeric = _Union(PositiveInteger, PositiveFloat)
	RowSpan = _Integer(0..65534)
	ColSpan = _Integer(0..1000)

	Step = _Union(Token(:any), PositiveNumeric)
	Token = _Union(String, Symbol)
	Tokens = _Union(Token, _Array(Token))
	UInt = _Integer(0..)
	AutocompleteNamedGroup = _String(/\Asection-/)

	Hatch = Enum(:open, :closed)
	Toggle = Enum(:on, :off)
	Affirmation = Enum(:yes, :no)
	EnumeratedBoolean = Enum(:true, :false)

	AttributionSource = _Union(_Boolean, String)
	Blocking = Enum(:render)

	FormEncoding = _Union(
		"application/x-www-form-urlencoded",
		"multipart/form-data",
		"text/plain",
	)

	Target = _Union(
		"_self",
		"_blank",
		"_parent",
		"_top",
		"_unfencedTop"
	)

	PopoverTargetAction = Enum(
		:hide,
		:show,
		:toggle
	)

	CrossOrigin = Enum(
		:anonymous,
		:user_credentials
	)

	FetchPriority = Enum(
		:low,
		:high,
		:auto,
	)

	Sizes = _Union(
		Token(:any),
		SpaceSeparatedList(
			_String(/\A\d+[xX]\d+\z/)
		),
	)

	# TODO — these times can have much stricter implementations
	Href = String
	Language = String
	ReferrerPolicy = Tokens
	ControlsList = Tokens # TODO: https://wicg.github.io/controls-list/explainer.html
	MimeType = String
	DOMID = String # TODO: We can actually verify that these IDs exist on the page

	ARel = Enum(
		:alternate,
		:author,
		:bookmark,
		:external,
		:help,
		:license,
		:me,
		:next,
		:nofollow,
		:noopener,
		:noreferrer,
		:opener,
		:prev,
		:privacy_policy,
		:search,
		:tag,
		:terms_of_service
	)

	FormRel = Enum(
		:external,
		:nofollow,
		:opener,
		:noopener,
		:noreferrer,
		:help,
		:prev,
		:next,
		:search,
		:license,
	)

	LinkRel = Enum(
		:alternate,
		:author,
		:canonical,
		:dns_prefetch,
		:expect,
		:help,
		:license,
		:manifest,
		:me,
		:modulepreload,
		:next,
		:pingback,
		:preconnect,
		:prefetch,
		:preload,
		:prerender,
		:prev,
		:privacy_policy,
		:search,
		:stylesheet,
		:terms_of_service
	)

	TextDirection = Enum(:ltr, :rtl)

	InputMode = Enum(
		:none,
		:text,
		:decimal,
		:numeric,
		:tel,
		:search,
		:email,
		:url
	)

	FormMethod = Enum(
		:post,
		:get,
		:dialog
	)

	AutocompleteGroupingIdentifier = Enum(
		:shipping,
		:billing,
	)

	AutocompleteRecipientType = Enum(
		:home,
		:work,
		:mobile,
		:fax,
		:page,
	)

	AutocompleteDigitalContact = Enum(
		:tel,
		:tel_country_code,
		:tel_national,
		:tel_area_code,
		:tel_local,
		:tel_extension,
		:email,
		:impp,
	)

	AutocompleteOther = Enum(
		:name,
		:honorific_prefix,
		:given_name,
		:additional_name,
		:family_name,
		:honorific_suffix,
		:nickname,
		:username,
		:new_password,
		:current_password,
		:one_time_code,
		:organization_title,
		:organization,
		:street_address,
		:address_line1,
		:address_line2,
		:address_line3,
		:address_level4,
		:address_level3,
		:address_level2,
		:address_level1,
		:country,
		:country_name,
		:postal_code,
		:cc_name,
		:cc_given_name,
		:cc_additional_name,
		:cc_family_name,
		:cc_number,
		:cc_exp,
		:cc_exp_month,
		:cc_exp_year,
		:cc_csc,
		:cc_type,
		:transaction_currency,
		:transaction_amount,
		:language,
		:bday,
		:bday_day,
		:bday_month,
		:bday_year,
		:sex,
		:url,
		:photo,
		:webauthn,
	)

	Autocomplete = _Union(
		Toggle,
		SpaceSeparatedList(
			_Union(
				AutocompleteNamedGroup,
				AutocompleteGroupingIdentifier,
				AutocompleteRecipientType,
				AutocompleteDigitalContact,
				AutocompleteOther,
			)
		)
	)

	BaseInputAttributes = {
		disabled: _Boolean,
		form: DOMID,
		name: _String(_Not("isindex")),
		value: _Union(String, Integer, Float),
	}.freeze

	TextishInputAttributes = {
		maxlength: UInt,
		minlength: UInt,
		pattern: String,
		placeholder: String,
		size: PositiveInteger,
	}.freeze

	GlobalAttributes = {
		accesskey: Tokens,
		autocapitalize: Enum(
			:on,
			:off,
			:none,
			:sentences,
			:words,
			:characters
		),
		autocorrect: Toggle,
		autofocus: _Boolean,
		class: Tokens,
		contenteditable: Enum(
			:true,
			:false,
			:plaintext_only
		),
		dir: _Union(
			Token(:auto),
			TextDirection,
		),
		draggable: EnumeratedBoolean,
		enterkeyhint: Enum(
			:enter,
			:done,
			:go,
			:next,
			:previous,
			:search,
			:send
		),
		exportparts: String, # TODO: investigate updating Phlex to comma-separate tokens passed to this attribute
		hidden: _Union(
			_Boolean,
			Enum(
				:hidden,
				:until_found
			)
		),
		id: DOMID,
		inert: _Boolean,
		inputmode: InputMode,
		is: Token,
		itemid: String,
		itemprop: String,
		itemref: Tokens,
		itemscope: _Boolean,
		itemtype: Token,
		lang: Language,
		nonce: Token,
		part: Token,
		popover: _Union(
			_Boolean,
			Enum(
				:auto,
				:hint,
				:manual
			)
		),
		slot: Token,
		spellcheck: EnumeratedBoolean,
		# TODO: figure out style
		tabindex: Integer,
		title: String,
		translate: Affirmation,
		virtualkeyboardpolicy: Enum(:auto, :manual),
		writingsuggestions: EnumeratedBoolean,
	}.freeze

	Attributes = {
		a: {
			attributionsrc: _Union(_Boolean, Token),
			download: Token,
			href: Href,
			hreflang: Language,
			ping: Tokens,
			referrerpolicy: ReferrerPolicy,
			rel: ARel,
			target: Target,
			type: MimeType,
		}.freeze,

		abbr: GlobalAttributes,

		address: GlobalAttributes,

		area: {
			alt: String,
			# TODO: define coords dynamically
			download: Token,
			href: Href,
			ping: Tokens,
			referrerpolicy: ReferrerPolicy,
			rel: ARel,
			shape: Enum(
				:rect,
				:circle,
				:poly,
				:default
			),
			target: Target,
		}.freeze,

		article: GlobalAttributes,

		aside: GlobalAttributes,

		audio: {
			autoplay: _Boolean,
			controls: _Boolean,
			controlslist: ControlsList,
			crossorigin: CrossOrigin,
			disableremoteplayback: _Boolean,
			loop: _Boolean,
			muted: _Boolean,
			preload: Enum(
				:none,
				:metadata,
				:auto
			),
			src: String,
		}.freeze,

		b: GlobalAttributes,

		base: {
			href: Href,
			target: Target, # TODO: verify that this is actually the same target as in other cases
		}.freeze,

		bdi: GlobalAttributes,

		bdo: {
			dir: TextDirection,
		}.freeze,

		blockquote: {
			cite: Href,
		}.freeze,

		body: {
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
		}.freeze,

		br: {
			clear: Deprecated,
		}.freeze,

		button: {
			autofocus: _Boolean,
			command: _Union(
				Enum(
					:show_modal,
					:close,
					:request_close,
					:show_popover,
					:hide_popover,
					:toggle_popover,
				),
				_String(/\A--/),
			),
			commandfor: DOMID,
			disabled: _Boolean,
			form: DOMID,
			formaction: Href,
			formenctype: FormEncoding,
			formmethod: FormMethod,
			formnovalidate: _Boolean,
			formtarget: Target, # TODO: verify this is actually the same target
			name: String,
			popovertarget: DOMID,
			popovertargetaction: PopoverTargetAction,
			type: Enum(
				:submit,
				:reset,
				:button
			),
			value: String,
		}.freeze,

		canvas: {
			height: Integer,
			width: Integer,
		}.freeze,

		caption: {
			align: Deprecated,
		}.freeze,

		cite: GlobalAttributes,

		code: GlobalAttributes,

		col: {
			span: UInt,
			align: Deprecated,
			bgcolor: Deprecated,
			char: Deprecated,
			charoff: Deprecated,
			valign: Deprecated,
			width: Deprecated,
		}.freeze,

		data: {
			value: Value,
		}.freeze,

		datalist: GlobalAttributes,

		dd: GlobalAttributes,

		del: {
			cite: Href,
			datetime: DateTimeString,
		}.freeze,

		details: {
			open: _Boolean,
			name: String,
		}.freeze,

		dfn: {
			title: String,
		}.freeze,

		dialog: {
			tabindex: _Never,
			open: _Boolean,
		}.freeze,

		div: {
			align: Deprecated,
		}.freeze,

		dl: GlobalAttributes,

		dt: GlobalAttributes,

		em: GlobalAttributes,

		embed: {
			height: UInt,
			src: Href,
			type: MimeType,
			width: UInt,
		}.freeze,

		fencedframe: {
			allow: String,
			height: UInt,
			width: UInt,
		}.freeze,

		fieldset: {
			disabled: _Boolean,
			form: DOMID,
			name: String,
		}.freeze,

		figcaption: GlobalAttributes,

		figure: GlobalAttributes,

		footer: GlobalAttributes,

		form: {
			accept: Deprecated,
			accept_charset: String, # TODO: comma-separated list of charsets
			autocomplete: Toggle,
			name: _String(length: 1..), # TODO: must be unique among the form elements in form collection that its in if any
			rel: SpaceSeparatedList(FormRel),
			action: Href,
			enctype: FormEncoding,
			method: FormMethod,
			novalidate: _Boolean,
			target: Target,
		}.freeze,

		h1: GlobalAttributes,

		h2: GlobalAttributes,

		h3: GlobalAttributes,

		h4: GlobalAttributes,

		h5: GlobalAttributes,

		h6: GlobalAttributes,

		head: {
			profile: Tokens, # TODO: improve this
		}.freeze,

		header: GlobalAttributes,

		hgroup: GlobalAttributes,

		hr: {
			align: Deprecated,
			color: Deprecated,
			noshade: Deprecated,
			size: Deprecated,
			width: Deprecated,
		}.freeze,

		html: {
			version: Deprecated,
			xmlns: String,
		}.freeze,

		i: GlobalAttributes,

		iframe: {
			allow: String,
			allowfullscreen: Deprecated,
			allowpaymentrequest: Deprecated,
			browsingtopics: _Boolean,
			credentialless: _Boolean,
			csp: String, # TODO: improve this
			height: UInt,
			loading: Enum(
				:eager,
				:lazy
			),
			name: String,
			referrerpolicy: ReferrerPolicy, # TODO: improve this
			sandbox: Enum(
				:allow_downloads,
				:allow_forms,
				:allow_modals,
				:allow_orientation_lock,
				:allow_pointer_lock,
				:allow_popups,
				:allow_popups_to_escape_sandbox,
				:allow_presentation,
				:allow_same_origin,
				:allow_scripts,
				:allow_storage_access_by_user_activation,
				:allow_top_navigation,
				:allow_top_navigation_by_user_activation,
				:allow_top_navigation_to_custom_protocols
			),
			src: Href,
			srcdoc: Phlex::HTML::SafeObject,
			width: UInt,
			align: Deprecated,
			frameborder: Deprecated,
			longdesc: Deprecated,
			marginheight: Deprecated,
			marginwidth: Deprecated,
			scrolling: Deprecated,
		}.freeze,

		img: {
			alt: String,
			attributionsrc: AttributionSource,
			crossorigin: CrossOrigin,
			decoding: Enum(
				:sync,
				:async,
				:auto
			),
			elementtiming: String,
			fetchpriority: FetchPriority,
			height: UInt,
			ismap: _Boolean,
			loading: Enum(
				:eager,
				:lazy
			),
			referrerpolicy: ReferrerPolicy,
			sizes: String, # todo comma-separated list of sizes
			src: Href,
			srcset: String, # todo: comma-separated list
			width: UInt,
			usemap: _String(/^#/),
			align: Deprecated,
			border: Deprecated,
			hspace: Deprecated,
			longdesc: Deprecated,
			name: Deprecated,
			vspace: Deprecated,
		}.freeze,

		input: {
			button: {
				**BaseInputAttributes,
				popovertarget: DOMID,
				popovertargetaction: PopoverTargetAction,
			}.freeze,

			checkbox: {
				**BaseInputAttributes,
				checked: _Boolean,
				required: _Boolean,
			}.freeze,

			color: {
				**BaseInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
			}.freeze,

			date: {
				**BaseInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
				max: DateString,
				min: DateString,
				readonly: _Boolean,
				required: _Boolean,
				step: Step,
			}.freeze,

			datetime_local: {
				**BaseInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
				max: DateTimeString,
				min: DateTimeString,
				readonly: _Boolean,
				required: _Boolean,
				step: Step,
			}.freeze,

			email: {
				**BaseInputAttributes,
				**TextishInputAttributes,
				autocapitalize: _Never,
				autocomplete: Autocomplete,
				list: DOMID,
				multiple: _Boolean,
				readonly: _Boolean,
				required: _Boolean,
			}.freeze,

			file: {
				**BaseInputAttributes,
				accept: String,
				autocomplete: Autocomplete,
				capture: Enum(:user, :environment),
				list: DOMID,
				multiple: _Boolean,
				readonly: _Boolean,
				required: _Boolean,
			}.freeze,

			hidden: {
				**BaseInputAttributes,
				autocomplete: Autocomplete,
				dirname: TextDirection,
				name: _String(_Not("_charset_"), _Not("isindex")),
			}.freeze,

			image: {
				**BaseInputAttributes,
				alt: String,
				formaction: Href,
				formenctype: FormEncoding,
				formmethod: FormMethod,
				formnovalidate: _Boolean,
				formtarget: Target,
				height: UInt,
				src: Href,
				value: _Never,
				width: UInt,
			}.freeze,

			month: {
				**BaseInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
				max: MonthString,
				min: MonthString,
				readonly: _Boolean,
				required: _Boolean,
				step: Step,
			}.freeze,

			number: {
				**BaseInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
				max: NumericValue, # todo should we validate that max is higher than min?
				min: NumericValue,
				placeholder: String,
				readonly: _Boolean,
				required: _Boolean,
				step: Step,
			}.freeze,

			password: {
				**BaseInputAttributes,
				**TextishInputAttributes,
				autocapitalize: _Never,
				autocomplete: Autocomplete,
				readonly: _Boolean,
				required: _Boolean,
			}.freeze,

			radio: {
				**BaseInputAttributes,
				checked: _Boolean,
				required: _Boolean,
			}.freeze,

			range: {
				**BaseInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
				max: NumericValue, # todo should we validate that max is higher than min?
				min: NumericValue,
				step: Step,
			}.freeze,

			reset: {
				**BaseInputAttributes,
			}.freeze,

			search: {
				**BaseInputAttributes,
				**TextishInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
				maxlength: UInt,
				minlength: UInt,
				readonly: _Boolean,
				required: _Boolean,
			}.freeze,

			submit: {
				**BaseInputAttributes,
				formaction: Href,
				formenctype: FormEncoding,
				formmethod: FormMethod,
				formnovalidate: _Boolean,
				formtarget: Target,
			}.freeze,

			tel: {
				**BaseInputAttributes,
				**TextishInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
				readonly: _Boolean,
				required: _Boolean,
			}.freeze,

			text: {
				**BaseInputAttributes,
				**TextishInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
				readonly: _Boolean,
				required: _Boolean,
			}.freeze,

			time: {
				**BaseInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
				max: TimeString,
				min: TimeString,
				readonly: _Boolean,
				required: _Boolean,
				step: Step,
			}.freeze,

			url: {
				**BaseInputAttributes,
				**TextishInputAttributes,
				autocapitalize: _Never,
				autocomplete: Autocomplete,
				list: DOMID,
				readonly: _Boolean,
				required: _Boolean,
			}.freeze,

			week: {
				**BaseInputAttributes,
				autocomplete: Autocomplete,
				list: DOMID,
				max: WeekString,
				min: WeekString,
				readonly: _Boolean,
				required: _Boolean,
				step: Step,
			}.freeze,
		}.freeze,

		ins: {
			cite: Href,
			datetime: DateTimeString,
		}.freeze,

		kbd: GlobalAttributes,

		label: {
			for: DOMID,
		}.freeze,

		legend: GlobalAttributes,

		li: {
			value: Integer,
			type: Deprecated,
		}.freeze,

		link: {
			as: Enum(
				:audio,
				:document,
				:embed,
				:fetch,
				:font,
				:image,
				:manifest,
				:object,
				:script,
				:style,
				:track,
				:video,
				:worker,
			),
			blocking: Blocking,
			crossorigin: CrossOrigin,
			disabled: _Boolean,
			fetchpriority: FetchPriority,
			href: Href,
			hreflang: Language,
			imagesizes: String, # todo
			imagesrcset: String, # todo
			integrity: String, # todo
			media: String, # todo — with a CSS parser, you could validate this further
			referrerpolicy: ReferrerPolicy,
			rel: LinkRel, # todo — we can do different validations with internal and externa links
			sizes: Sizes,
			title: String,
			type: MimeType,
			target: _Never,
			charset: Deprecated,
			rev: Deprecated,
		}.freeze,

		main: GlobalAttributes,

		map: {
			name: String,
		}.freeze,

		mark: GlobalAttributes,

		menu: GlobalAttributes,

		meta: {
			charset: Token(:utf_8),
			content: String,
			http_equiv: Enum(
				:content_security_policy,
				:content_type,
				:default_style,
				:x_ua_compatible,
				:refresh
			),
			media: String,
			name: String,
		}.freeze,

		meter: {
			value: NumericValue,
			min: NumericValue,
			max: NumericValue,
			low: NumericValue,
			high: NumericValue,
			optimum: NumericValue,
			form: DOMID,
		}.freeze,

		nav: GlobalAttributes,

		noscript: GlobalAttributes,

		object: {
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
		}.freeze,

		ol: {
			reversed: _Boolean,
			start: UInt,
			type: _Union(
				1,
				"a",
				"A",
				"i",
				"I"
			),
		}.freeze,

		optgroup: GlobalAttributes,

		option: {
			disabled: _Boolean,
			label: String,
			selected: _Boolean,
			value: String,
		}.freeze,

		output: {
			for: SpaceSeparatedList(DOMID),
			form: DOMID,
			name: String,
		}.freeze,

		p: GlobalAttributes,

		picture: GlobalAttributes,

		pre: {
			width: Deprecated,
			wrap: Deprecated,
		}.freeze,

		progress: {
			value: PositiveNumeric,
			max: PositiveNumeric,
		}.freeze,

		q: {
			cite: Href,
		}.freeze,

		rp: GlobalAttributes,

		rt: GlobalAttributes,

		ruby: GlobalAttributes,

		s: GlobalAttributes,

		samp: GlobalAttributes,

		script: {
			async: _Boolean,
			attributionsrc: AttributionSource,
			blocking: Blocking,
			crossorigin: CrossOrigin,
			defer: _Boolean,
			fetchpriority: FetchPriority,
			integrity: String, # TODO: maybe this can be validated
			nomodule: _Boolean,
			nonce: String,
			referrerpolicy: ReferrerPolicy,
			src: Href,
			type: Enum(
				:importmap,
				:module,
				:speculationrules,
			),
			charset: Deprecated,
			language: Deprecated,
		}.freeze,

		search: GlobalAttributes,

		section: GlobalAttributes,

		select: {
			autocomplete: Autocomplete,
			autofocus: _Boolean,
			disabled: _Boolean,
			form: DOMID,
			multiple: _Boolean,
			name: String,
			required: _Boolean,
			size: UInt,
		}.freeze,

		slot: {
			name: String,
		}.freeze,

		small: GlobalAttributes,

		source: {
			type: MimeType,
			src: Href,
			srcset: String, # todo
			sizes: Sizes,
			media: String,
			height: UInt,
			width: UInt,
		}.freeze,

		span: GlobalAttributes,

		strong: GlobalAttributes,

		style: {
			blocking: Blocking,
			media: String,
			nonce: String,
			title: String,
			type: Deprecated,
		}.freeze,

		sub: GlobalAttributes,

		summary: GlobalAttributes,

		sup: GlobalAttributes,

		table: {
			align: Deprecated,
			bgcolor: Deprecated,
			border: Deprecated,
			cellpadding: Deprecated,
			cellspacing: Deprecated,
			frame: Deprecated,
			rules: Deprecated,
			summary: Deprecated,
			width: Deprecated,
		}.freeze,

		tbody: {
			align: Deprecated,
			bgcolor: Deprecated,
			char: Deprecated,
			charoff: Deprecated,
			valign: Deprecated,
		}.freeze,

		td: {
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
		}.freeze,

		template: {
			shadowrootmode: Hatch,
			shadowrootclonable: _Boolean,
			shadowrootdelegatesfocus: _Boolean,
			shadowrootserializable: _Boolean,
		}.freeze,

		textarea: {
			autocomplete: Autocomplete,
			cols: PositiveInteger,
			dirname: TextDirection,
			disabled: _Boolean,
			form: DOMID,
			maxlength: UInt,
			minlength: UInt,
			name: String,
			placeholder: String,
			readonly: _Boolean,
			required: _Boolean,
			rows: PositiveInteger,
			spellcheck: Enum(:true, :false, :default),
			wrap: Enum(:hard, :soft),
		}.freeze,

		tfoot: {
			align: Deprecated,
			bgcolor: Deprecated,
			char: Deprecated,
			charoff: Deprecated,
			valign: Deprecated,
		}.freeze,

		th: {
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
		}.freeze,

		thead: {
			align: Deprecated,
			bgcolor: Deprecated,
			char: Deprecated,
			charoff: Deprecated,
			valign: Deprecated,
		}.freeze,

		time: {
			datetime: _Union(
				YearString,
				WeekString,
				MonthString,
				DateString,
				TimeZoneOffset,
				AbstractTime,
				AbstractDayOfMonth,
				LocalDateTimeString,
				DateTimeString,
				DurationString,
				PeriodString,
			),
		}.freeze,

		tr: {
			align: Deprecated,
			bgcolor: Deprecated,
			char: Deprecated,
			charoff: Deprecated,
			valign: Deprecated,
		}.freeze,

		track: {
			default: _Boolean,
			kind: Enum(:subtitles, :captions, :chapters, :metadata),
			label: String,
			src: Href,
			srclang: BCP47Language,
		}.freeze,

		tt: GlobalAttributes,

		u: GlobalAttributes,

		ul: {
			compact: Deprecated,
			type: Deprecated,
		}.freeze,

		var: GlobalAttributes,

		video: {
			autoplay: _Boolean,
			controls: _Boolean,
			controlslist: Enum(:nodownload, :nofullscreen, :noremoteplayback),
			crossorigin: CrossOrigin,
			disablepictureinpicture: _Boolean,
			disableremoteplayback: _Boolean,
			height: UInt,
			loop: _Boolean,
			muted: _Boolean,
			playsinline: _Boolean,
			poster: Href,
			preload: Enum(:none, :metadata, :auto),
			src: Href,
			width: UInt,
		}.freeze,

		wbr: GlobalAttributes,
	}.freeze
end
