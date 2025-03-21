# frozen_string_literal: true

test "time[datetime] with month" do
	assert_valid_html { time(datetime: "2011-11") }
	assert_valid_html { time(datetime: "2013-05") }

	refute_valid_html { time(datetime: "2011-1") }
	refute_valid_html { time(datetime: "2011-00") }
	refute_valid_html { time(datetime: "2011-13") }
end

test "time[datetime] with date" do
	assert_valid_html { time(datetime: "1887-12-01") }
	assert_valid_html { time(datetime: "1888-02-29") } # leap year

	refute_valid_html { time(datetime: "1887-02-29") }
end

test "time[datetime] with abstract day of month" do
	assert_valid_html { time(datetime: "11-12") }
end

test "time[datetime] with abstract time" do
	assert_valid_html { time(datetime: "23:59") }
	assert_valid_html { time(datetime: "12:15:47") }
	assert_valid_html { time(datetime: "12:15:52.999") }

	refute_valid_html { time(datetime: "24") }
	refute_valid_html { time(datetime: "24:00") }
	refute_valid_html { time(datetime: "2:00") }
	refute_valid_html { time(datetime: "23:1") }
	refute_valid_html { time(datetime: "12:60") }
	refute_valid_html { time(datetime: "23:59.123") }
	refute_valid_html { time(datetime: "12:15:60") }
	refute_valid_html { time(datetime: "12:15:52.99") }
end

test "time[date] with local date and time" do
	assert_valid_html { time(datetime: "2013-12-25 11:12") }
	assert_valid_html { time(datetime: "1972-07-25 13:43:07") }
	assert_valid_html { time(datetime: "1941-03-15 07:06:23.678") }
	assert_valid_html { time(datetime: "2013-12-25T11:12") }
	assert_valid_html { time(datetime: "1972-07-25T13:43:07") }
	assert_valid_html { time(datetime: "1941-03-15T07:06:23.678") }
end

test "time[datetime] with time-zone offset string" do
	assert_valid_html { time(datetime: "Z") }
	assert_valid_html { time(datetime: "+0200") }
	assert_valid_html { time(datetime: "+04:30") }
	assert_valid_html { time(datetime: "-0300") }
	assert_valid_html { time(datetime: "-08:00") }

	refute_valid_html { time(datetime: "+25:00") }
	refute_valid_html { time(datetime: "+1:00") }
	refute_valid_html { time(datetime: "+01:60") }
end

test "time[datetime] with global date and time" do
	assert_valid_html { time(datetime: "2013-12-25 11:12+0200") }
	assert_valid_html { time(datetime: "1972-07-25 13:43:07+04:30") }
	assert_valid_html { time(datetime: "1941-03-15 07:06:23.678Z") }
	assert_valid_html { time(datetime: "2013-12-25T11:12-08:00") }
end

test "time[datetime] with week" do
	assert_valid_html { time(datetime: "2013-W46") }
	assert_valid_html { time(datetime: "2013-W52") }
	assert_valid_html { time(datetime: "2015-W53") }

	refute_valid_html { time(datetime: "2013-W1") }
	refute_valid_html { time(datetime: "2013-W54") }
end

test "time[datetime] with a year" do
	assert_valid_html { time(datetime: "0001") }
	assert_valid_html { time(datetime: "2025") }
	assert_valid_html { time(datetime: "10025") }

	refute_valid_html { time(datetime: "0000") }
	refute_valid_html { time(datetime: "123") }
end

# test "time[datetime] with duration" do
# 	assert_valid_html { time(datetime: "P12DT7H12M13S") }
# 	assert_valid_html { time(datetime: "P12DT7H12M13.3S") }
# 	assert_valid_html { time(datetime: "P12DT7H12M13.45S") }
# 	assert_valid_html { time(datetime: "P12DT7H12M13.455S") }
# 	assert_valid_html { time(datetime: "PT7H12M13S") }
# 	assert_valid_html { time(datetime: "PT7H12M13.2S") }
# 	assert_valid_html { time(datetime: "PT7H12M13.56S") }
# 	assert_valid_html { time(datetime: "PT7H12M13.999S") }
# 	assert_valid_html { time(datetime: "7d 5h 24m 13s") }
# end
