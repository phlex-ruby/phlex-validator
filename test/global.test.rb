# frozen_string_literal: true

test "[contenteditable]" do
	assert_valid_html { div(contenteditable: nil) }

	assert_valid_html { div(contenteditable: "true") }
	assert_valid_html { div(contenteditable: "false") }
	assert_valid_html { div(contenteditable: "plaintext-only") }

	assert_valid_html { div(contenteditable: :true) }
	assert_valid_html { div(contenteditable: :false) }
	assert_valid_html { div(contenteditable: :plaintext_only) }

	refute_valid_html { div(contenteditable: true) }
	refute_valid_html { div(contenteditable: false) }
	refute_valid_html { div(contenteditable: "invalid") }
	refute_valid_html { div(contenteditable: :invalid) }
	refute_valid_html { div(contenteditable: {}) }
	refute_valid_html { div(contenteditable: []) }
end

test "[translate]" do
	assert_valid_html { div(translate: "yes") }
	assert_valid_html { div(translate: "no") }

	refute_valid_html { div(translate: true) }
	refute_valid_html { div(translate: false) }
	refute_valid_html { div(translate: "true") }
	refute_valid_html { div(translate: "false") }
end
