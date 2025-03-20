# frozen_string_literal: true

test "bdo[dir]" do
	assert_valid_html { bdo(dir: "ltr") }
	assert_valid_html { bdo(dir: "rtl") }

	refute_valid_html { bdo(dir: "auto") }
end
