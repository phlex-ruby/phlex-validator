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
	PositiveNumeric = _Constraint(Integer, Float, 0.., _Not(0), _Not(0.0))
	PositiveInteger = _Integer(1..)
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
	MimeType = Token
	DOMID = Token # TODO: We can actually verify that these IDs exist on the page

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
end
