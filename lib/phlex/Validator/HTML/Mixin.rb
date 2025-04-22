# frozen_string_literal: true

module Phlex::Validator::HTML
	module Mixin
		def __validate__(tag, attributes)
			schema = case tag
			when :input
				input_type = attributes[:type]
				input_type = input_type.tr("-", "_").to_sym if String === input_type

				Attributes[:input][input_type]
			else
				Attributes[tag]
			end

			attributes.each do |k, v|
				# All attributes are nilable
				next if nil === v

				# Ignore string keys as an escape hatch
				next if String === k

				# If the key is not a String, it must be a Symbol
				raise ArgumentError unless Symbol === k

				type = schema[k]
				docs = "https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/#{tag}##{k}"

				unless (type || GlobalAttributes[k] || Attribute) === v
					raise TypeError.new <<~MESSAGE
						Invalid HTML attribute value

						Attribute: #{tag}[#{k}]
						Docs: #{docs}

						Expected: #{type.inspect}
						Actual (#{v.class.inspect}): #{v.inspect}
					MESSAGE
				end
			end
		end

		[
			:a,
			:abbr,
			:address,
			:area,
			:article,
			:aside,
			:audio,
			:b,
			:base,
			:bdi,
			:bdo,
			:blockquote,
			:body,
			:br,
			:button,
			:caption,
			:cite,
			:code,
			:col,
			:colgroup,
			:data,
			:datalist,
			:dd,
			:del,
			:details,
			:dfn,
			:dialog,
			:div,
			:dl,
			:dt,
			:em,
			:embed,
			:fencedframe,
			:fieldset,
			:figcaption,
			:figure,
			:footer,
			:form,
			:h1,
			:h2,
			:h3,
			:h4,
			:h5,
			:h6,
			:head,
			:header,
			:hgroup,
			:hr,
			:html,
			:i,
			:iframe,
			:img,
			:ins,
			:input,
			:kbd,
			:label,
			:legend,
			:li,
			:link,
			:main,
			:map,
			:mark,
			:menu,
			:meta,
			:meter,
			:nav,
			:noscript,
			:object,
			:ol,
			:optgroup,
			:option,
			:output,
			:p,
			:picture,
			:pre,
			:progress,
			:q,
			:rp,
			:rt,
			:ruby,
			:s,
			:samp,
			:script,
			:search,
			:section,
			:select,
			:slot,
			:small,
			:source,
			:span,
			:strong,
			:style,
			:sub,
			:summary,
			:sup,
			:table,
			:tbody,
			:td,
			:template,
			:textarea,
			:tfoot,
			:th,
			:thead,
			:time,
			:title,
			:tr,
			:track,
			:tt,
			:u,
			:ul,
			:var,
			:video,
			:wbr,
		].freeze.each do |tag|
			module_eval(<<~RUBY, __FILE__, __LINE__ + 1)
				# frozen_string_literal: true

				def #{tag.name}(**attributes)
					__validate__(:#{tag.name}, attributes)
					super
				end
			RUBY
		end
	end
end
