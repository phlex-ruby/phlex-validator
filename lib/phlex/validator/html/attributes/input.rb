# frozen_string_literal: true

module Phlex::Validator::HTML
	BaseInputAttributes = {
		**Attributes::Global,
		disabled: _Boolean,
		form: DOMID,
		name: _String(_Not("isindex")),
		value: _Union(String, Integer, Float),
	}.freeze

	private_constant :BaseInputAttributes

	TextishInputAttributes = {
		maxlength: UInt,
		minlength: UInt,
		pattern: String,
		placeholder: String,
		size: _Integer(1..),
	}.freeze

	private_constant :TextishInputAttributes

	Attributes::Input = {
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
				capture: Enum("user", "environment"),
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
		}.freeze
end
