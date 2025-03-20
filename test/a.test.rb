# frozen_string_literal: true

test "a[href]" do
	assert_valid_html { a(href: nil) }
	assert_valid_html { a(href: "/") }
	assert_valid_html { a(href: "https://github.com") }
	assert_valid_html { a(href: "") }

	refute_valid_html { a(href: 1) }
end

test "a[attributionsrc]" do
	assert_valid_html { a(attributionsrc: nil) }
	assert_valid_html { a(attributionsrc: true) }
	assert_valid_html { a(attributionsrc: false) }
	assert_valid_html { a(attributionsrc: "foo") }

	refute_valid_html { a(attributionsrc: 1) }
	refute_valid_html { a(attributionsrc: {}) }
	refute_valid_html { a(attributionsrc: []) }
end
