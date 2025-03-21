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
			_Array(type),
			_String(-> (it) { it.split(/\s*,\s*/).all?(type) })
		)
	end

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

	DateString = _String(/\A([0-9]{4})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])\z/)
	WeekString = _String(/\A([0-9]{4})-W(0[1-9]|[1-4][0-9]|5[0-3])\z/)
	MonthString = _String(/\A([0-9]{4})-(0[1-9]|1[0-2])\z/)
	DateTimeString = _String(/\A([0-9]{4})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])T([01][0-9]|2[0-3]):([0-5][0-9])(:[0-5][0-9])?\z/)

	Deprecated = _Never
	JavaScript = Phlex::HTML::SafeObject
	EmailAddressString = _String(URI::MailTo::EMAIL_REGEXP)
	NumericString = _String(/\A-?(\d+(\.\d*)?|\.\d+)\z/)
	NumericValue = _Union(Integer, Float, NumericString)

	# An integer or float that’s greater than zero
	PositiveNumeric = _Constraint(Integer, Float, 0.., _Not(0), _Not(0.0))
	PositiveInteger = _Integer(1..)

	Step = _Union(Token(:any), PositiveNumeric)
	TimeString = _String(/\A([01][0-9]|2[0-3]):([0-5][0-9])(:[0-5][0-9](\.\d{1,3})?)?\z/)
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
		:high,
		:low,
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
	ARel = Token
	Target = Token
	MimeType = Token
	DOMID = Token # TODO: We can actually verify that these IDs exist on the page

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
end
