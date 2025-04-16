# frozen_string_literal: true

module Phlex::Validator::HTML
	module Mixin
		def __validate__(attributes, schema)
			attributes.each do |k, v|
				# All attributes are nilable
				next if nil === v

				# Ignore string keys as an escape hatch
				next if String === k

				# If the key is not a String, it must be a Symbol
				raise ArgumentError unless Symbol === k

				Literal.check(v, schema[k] || GlobalAttributes[k] || Attribute)
			end
		end

		def a(**attributes)
			__validate__(attributes, Attributes[:a])
			super
		end

		def abbr(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def address(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def area(**attributes)
			__validate__(attributes, Attributes[:area])
			super
		end

		def article(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def aside(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def audio(**attributes)
			__validate__(attributes, Attributes[:audio])
			super
		end

		def b(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		# TODO: We should validate that this comes before other link like tags
		# TODO: We should ensure at least one of `href` or `target` are set
		def base(**attributes)
			__validate__(attributes, Attributes[:base])
			super
		end

		def bdi(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def bdo(**attributes)
			__validate__(attributes, Attributes[:bdo])
			super
		end

		def blockquote(**attributes)
			__validate__(attributes, Attributes[:blockquote])
			super
		end

		def body(**attributes)
			__validate__(attributes, Attributes[:body])
			super
		end

		def br(**attributes)
			__validate__(attributes, Attributes[:br])
			super
		end

		def button(**attributes)
			__validate__(attributes, Attributes[:button])
			super
		end

		def caption(**attributes)
			__validate__(attributes, Attributes[:caption])
			super
		end

		def cite(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def code(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def col(**attributes)
			__validate__(attributes, Attributes[:col])
			super
		end

		def colgroup(**attributes)
			__validate__(attributes, Attributes[:col])
			super
		end

		def data(**attributes)
			__validate__(attributes, Attributes[:data])
			super
		end

		def datalist(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def dd(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def del(**attributes)
			__validate__(attributes, Attributes[:del])
			super
		end

		def details(**attributes)
			__validate__(attributes, Attributes[:details])
			super
		end

		def dfn(**attributes)
			__validate__(attributes, Attributes[:dfn])
			super
		end

		def dialog(**attributes)
			__validate__(attributes, Attributes[:dialog])
			super
		end

		def div(**attributes)
			__validate__(attributes, Attributes[:div])
			super
		end

		def dl(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def dt(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def em(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def embed(**attributes)
			__validate__(attributes, Attributes[:embed])
			super
		end

		def fencedframe(**attributes)
			__validate__(attributes, Attributes[:fencedframe])
			super
		end

		def fieldset(**attributes)
			__validate__(attributes, Attributes[:fieldset])
			super
		end

		def figcaption(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def figure(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def footer(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def form(**attributes)
			__validate__(attributes, Attributes[:form])
			super
		end

		def h1(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def h2(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def h3(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def h4(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def h5(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def h6(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def head(**attributes)
			__validate__(attributes, Attributes[:head])
			super
		end

		def header(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def hgroup(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def hr(**attributes)
			__validate__(attributes, Attributes[:hr])
			super
		end

		def html(**attributes)
			__validate__(attributes, Attributes[:html])
			super
		end

		def i(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def iframe(**attributes)
			__validate__(attributes, Attributes[:iframe])
			super
		end

		def img(**attributes)
			__validate__(attributes, Attributes[:img])
			super
		end

		def input(type:, name:, **attributes)
			# TODO: handle non existing type
			type = type.tr("-", "_").to_sym if String === type

			__validate__({ type:, name:, **attributes }, Attributes[:input][type])
			super
		end

		def ins(**attributes)
			__validate__(attributes, Attributes[:ins])
			super
		end

		def kbd(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def label(**attributes)
			__validate__(attributes, Attributes[:label])
			super
		end

		def legend(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def li(**attributes)
			__validate__(attributes, Attributes[:li])
			super
		end

		def link(**attributes)
			__validate__(attributes, Attributes[:link])
			super
		end

		def main(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def map(**attributes)
			__validate__(attributes, Attributes[:map])
			super
		end

		def mark(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def menu(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def meta(**attributes)
			__validate__(attributes, Attributes[:meta])
			super
		end

		def meter(**attributes)
			__validate__(attributes, Attributes[:meter])
			super
		end

		def nav(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def noscript(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def object(**attributes)
			__validate__(attributes, Attributes[:object])
			super
		end

		def ol(**attributes)
			__validate__(attributes, Attributes[:ol])
			super
		end

		def optgroup(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def option(**attributes)
			__validate__(attributes, Attributes[:option])
			super
		end

		def output(**attributes)
			__validate__(attributes, Attributes[:output])
			super
		end

		def p(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def picture(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def pre(**attributes)
			__validate__(attributes, Attributes[:pre])
		end

		def progress(**attributes)
			__validate__(attributes, Attributes[:progress])
			super
		end

		def q(**attributes)
			__validate__(attributes, Attributes[:q])
			super
		end

		def rp(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def rt(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def ruby(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def s(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def samp(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def script(**attributes)
			__validate__(attributes, Attributes[:script])
			super
		end

		def search(**attributes)
			__validate__(attributes, GlobalAttributes)
		end

		def section(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def select(**attributes)
			__validate__(attributes, Attributes[:select])
			super
		end

		def slot(**attributes)
			__validate__(attributes, Attributes[:slot])
			super
		end

		def small(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def source(**attributes)
			__validate__(attributes, Attributes[:source])
			super
		end

		def span(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def strong(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def style(**attributes)
			__validate__(attributes, Attributes[:style])
			super
		end

		def sub(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def summary(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def sup(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def table(**attributes)
			__validate__(attributes, Attributes[:table])
			super
		end

		def tbody(**attributes)
			__validate__(attributes, Attributes[:tbody])
			super
		end

		def td(**attributes)
			__validate__(attributes, Attributes[:td])
			super
		end

		def template(**attributes)
			__validate__(attributes, Attributes[:template])
			super
		end

		def textarea(**attributes)
			__validate__(attributes, Attributes[:textarea])
			super
		end

		def tfoot(**attributes)
			__validate__(attributes, Attributes[:tfoot])
			super
		end

		def th(**attributes)
			__validate__(attributes, Attributes[:th])
			super
		end

		def thead(**attributes)
			__validate__(attributes, Attributes[:thead])
			super
		end

		def time(**attributes)
			__validate__(attributes, Attributes[:time])
			super
		end

		def title(**attributes)
			__validate__(attributes, Attributes[:title])
			super
		end

		def tr(**attributes)
			__validate__(attributes, Attributes[:tr])
			super
		end

		def track(**attributes)
			__validate__(attributes, Attributes[:track])
			super
		end

		def tt(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def u(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def ul(**attributes)
			__validate__(attributes, Attributes[:ul])
			super
		end

		def var(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end

		def video(**attributes)
			__validate__(attributes, Attributes[:video])
			super
		end

		def wbr(**attributes)
			__validate__(attributes, GlobalAttributes)
			super
		end
	end
end
