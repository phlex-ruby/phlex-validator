# frozen_string_literal: true

module Phlex::Validator::HTML
	Attributes::Time = {
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
	}.freeze
end
