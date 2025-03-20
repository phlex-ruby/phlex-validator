# frozen_string_literal: true

# TODO: Only one element in the document can have the `autofocus` attribute.

module Phlex::Validator::HTML
	extend Literal::Types

	def self.Token(string)
		_Union(
			string,
			string.tr("-", "_").to_sym
		)
	end

	def self.Enum(*tokens)
		_Union(*tokens, *tokens.map { |it| it.tr("-", "_").to_sym })
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

	Step = _Union(Token("any"), PositiveNumeric)
	TimeString = _String(/\A([01][0-9]|2[0-3]):([0-5][0-9])(:[0-5][0-9](\.\d{1,3})?)?\z/)
	Token = _Union(String, Symbol)
	Tokens = _Union(Token, _Array(Token))
	UInt = _Integer(0..)
	AutocompleteNamedGroup = _String(/\Asection-/)
	Toggle = Enum("on", "off")
	EnumeratedBoolean = Enum("true", "false")
	Affirmation = Enum("yes", "no")

	FormEncoding = _Union(
		"application/x-www-form-urlencoded",
		"multipart/form-data",
		"text/plain",
	)

	PopoverTargetAction = Enum(
		"hide",
		"show",
		"toggle"
	)

	CrossOrigin = Enum(
		"anonymous",
		"use-credentials"
	)

	FetchPriority = Enum(
		"high",
		"low",
		"auto"
	)

	Sizes = _Union(
		Token("any"),
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
		"alternate",
		"author",
		"canonical",
		"dns-prefetch",
		"expect",
		"help",
		"license",
		"manifest",
		"me",
		"modulepreload",
		"next",
		"pingback",
		"preconnect",
		"prefetch",
		"preload",
		"prerender",
		"prev",
		"privacy-policy",
		"search",
		"stylesheet",
		"terms-of-service"
	)

	TextDirection = Enum("ltr", "rtl")

	InputMode = Enum(
		"none",
		"text",
		"decimal",
		"numeric",
		"tel",
		"search",
		"email",
		"url"
	)

	FormMethod = Enum(
		"post",
		"get",
		"dialog"
	)

	AutocompleteGroupingIdentifier = Enum(
		"shipping",
		"billing",
	)

	AutocompleteRecipientType = Enum(
		"home",
		"work",
		"mobile",
		"fax",
		"page",
	)

	AutocompleteDigitalContact = Enum(
		"tel",
		"tel-country-code",
		"tel-national",
		"tel-area-code",
		"tel-local",
		"tel-extension",
		"email",
		"impp",
	)

	AutocompleteOther = Enum(
		"name",
		"honorific-prefix",
		"given-name",
		"additional-name",
		"family-name",
		"honorific-suffix",
		"nickname",
		"username",
		"new-password",
		"current-password",
		"one-time-code",
		"organization-title",
		"organization",
		"street-address",
		"address-line1",
		"address-line2",
		"address-line3",
		"address-level4",
		"address-level3",
		"address-level2",
		"address-level1",
		"country",
		"country-name",
		"postal-code",
		"cc-name",
		"cc-given-name",
		"cc-additional-name",
		"cc-family-name",
		"cc-number",
		"cc-exp",
		"cc-exp-month",
		"cc-exp-year",
		"cc-csc",
		"cc-type",
		"transaction-currency",
		"transaction-amount",
		"language",
		"bday",
		"bday-day",
		"bday-month",
		"bday-year",
		"sex",
		"url",
		"photo",
		"webauthn",
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
