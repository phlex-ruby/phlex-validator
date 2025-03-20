# frozen_string_literal: true

[
	"color",
	"date",
	"datetime-local",
	"email",
	"file",
	"hidden",
	"month",
	"number",
	"password",
	"range",
	"search",
	"tel",
	"text",
	"time",
	"url",
	"week",
].each do |type|
	test "input[type='#{type}'][autocomplete]" do
		assert_valid_html { input(type:, name: "example", autocomplete: "on") }
		assert_valid_html { input(type:, name: "example", autocomplete: "off") }
		assert_valid_html { input(type:, name: "example", autocomplete: "section-foo") }
		assert_valid_html { input(type:, name: "example", autocomplete: "shipping") }
		assert_valid_html { input(type:, name: "example", autocomplete: "home") }
		assert_valid_html { input(type:, name: "example", autocomplete: :home) }
		assert_valid_html { input(type:, name: "example", autocomplete: "tel tel-country-code") }
		assert_valid_html { input(type:, name: "example", autocomplete: "name given-name") }
		assert_valid_html { input(type:, name: "example", autocomplete: ["name", :given_name]) }

		refute_valid_html { input(type:, name: "example", autocomplete: "invalid") }
	end
end

test "input[maxlength]" do
	assert_valid_html { input(type: "text", name: "example", maxlength: 5) }

	refute_valid_html { input(type: "text", name: "example", maxlength: "invalid") }
end

test "input[name]" do
	assert_valid_html { input(type: "text", name: "example") }
	assert_valid_html { input(type: "text", name: "example", value: "value") }

	refute_valid_html { input(type: "text", name: "isindex") }
end

test "input[type='hidden'][name]" do
	assert_valid_html { input(type: "hidden", name: "example") }
	assert_valid_html { input(type: "hidden", name: "example", value: "value") }

	refute_valid_html { input(type: "hidden", name: "_charset_") }
	refute_valid_html { input(type: "hidden", name: "isindex") }
end
