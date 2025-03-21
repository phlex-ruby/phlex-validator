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

				Literal.check(
					expected: schema[k] || Attributes::Global[k] || Attribute,
					actual: v
				)
			end
		end

		def a(**attributes)
			__validate__(attributes, Attributes::A)
			super
		end

		def abbr(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def address(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def area(**attributes)
			__validate__(attributes, Attributes::Area)
			super
		end

		def article(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def aside(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def audio(**attributes)
			__validate__(attributes, Attributes::Audio)
			super
		end

		def b(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		# TODO: We should validate that this comes before other link like tags
		# TODO: We should ensure at least one of `href` or `target` are set
		def base(**attributes)
			__validate__(attributes, Attributes::Base)
			super
		end

		def bdi(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def bdo(**attributes)
			__validate__(attributes, Attributes::Bdo)
			super
		end

		def blockquote(**attributes)
			__validate__(attributes, Attributes::Blockquote)
			super
		end

		def body(**attributes)
			__validate__(attributes, Attributes::Body)
			super
		end

		def br(**attributes)
			__validate__(attributes, Attributes::Br)
			super
		end

		def button(**attributes)
			__validate__(attributes, Attributes::Button)
			super
		end

		def caption(**attributes)
			__validate__(attributes, Attributes::Caption)
			super
		end

		def cite(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def code(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def col(**attributes)
			__validate__(attributes, Attributes::Col)
			super
		end

		def colgroup(**attributes)
			__validate__(attributes, Attributes::Col)
			super
		end

		def data(**attributes)
			__validate__(attributes, Attributes::Data)
			super
		end

		def datalist(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def dd(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def del(**attributes)
			__validate__(attributes, Attributes::Del)
			super
		end

		def details(**attributes)
			__validate__(attributes, Attributes::Details)
			super
		end

		def dfn(**attributes)
			__validate__(attributes, Attributes::Dfn)
			super
		end

		def dialog(**attributes)
			__validate__(attributes, Attributes::Dialog)
			super
		end

		def div(**attributes)
			__validate__(attributes, Attributes::Div)
			super
		end

		def dl(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def dt(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def em(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def embed(**attributes)
			__validate__(attributes, Attributes::Embed)
			super
		end

		def fencedframe(**attributes)
			__validate__(attributes, Attributes::Fencedframe)
			super
		end

		def fieldset(**attributes)
			__validate__(attributes, Attributes::Fieldset)
			super
		end

		def figcaption(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def figure(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def footer(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def form(**attributes)
			__validate__(attributes, Attributes::Form)
			super
		end

		def h1(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def h2(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def h3(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def h4(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def h5(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def h6(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def head(**attributes)
			__validate__(attributes, Attributes::Head)
			super
		end

		def header(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def hgroup(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def hr(**attributes)
			__validate__(attributes, Attributes::Hr)
			super
		end

		def html(**attributes)
			__validate__(attributes, Attribute::HTML)
			super
		end

		def i(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def iframe(**attributes)
			__validate__(attributes, Attributes::Iframe)
			super
		end

		def img(**attributes)
			__validate__(attributes, Attributes::Img)
			super
		end

		def input(type:, name:, **attributes)
			# TODO: handle non existing type
			type = type.tr("-", "_").to_sym if String === type

			__validate__({ type:, name:, **attributes }, Attributes::Input[type])
			super
		end

		def ins(**attributes)
			__validate__(attributes, Attributes::Ins)
			super
		end

		def kbd(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def label(**attributes)
			__validate__(attributes, Attributes::Label)
			super
		end

		def legend(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def li(**attributes)
			__validate__(attributes, Attributes::Li)
			super
		end

		def link(**attributes)
			__validate__(attributes, Attributes::Link)
			super
		end

		def main(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def map(**attributes)
			__validate__(attributes, Attributes::Map)
			super
		end

		def mark(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def menu(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def meta(**attributes)
			__validate__(attributes, Attributes::Meta)
			super
		end

		def meter(**attributes)
			__validate__(attributes, Attributes::Meter)
			super
		end

		def nav(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def noscript(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def object(**attributes)
			__validate__(attributes, Attributes::Object)
			super
		end

		def ol(**attributes)
			__validate__(attributes, Attributes::Ol)
			super
		end

		def optgroup(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def output(**attributes)
			__validate__(attributes, Attributes::Output)
			super
		end

		def p(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def picture(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def pre(**attributes)
			__validate__(attributes, Attributes::Pre)
		end

		def progress(**attributes)
			__validate__(attributes, Attributes::Progress)
			super
		end

		def q(**attributes)
			__validate__(attributes, Attributes::Q)
			super
		end

		def rp(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def rt(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def ruby(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def s(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def samp(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def script(**attributes)
			__validate__(attributes, Attributes::Script)
			super
		end

		def search(**attributes)
			__validate__(attributes, Attributes::Global)
		end

		def section(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def select(**attributes)
			__validate__(attributes, Attributes::Select)
			super
		end

		def slot(**attributes)
			__validate__(attributes, Attributes::Slot)
			super
		end

		def small(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def source(**attributes)
			__validate__(attributes, Attributes::Source)
			super
		end

		def span(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def strong(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def style(**attributes)
			__validate__(attributes, Attributes::Style)
			super
		end

		def sub(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def summary(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def sup(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def table(**attributes)
			__validate__(attributes, Attributes::Table)
			super
		end

		def tbody(**attributes)
			__validate__(attributes, Attributes::Tbody)
			super
		end

		def td(**attributes)
			__validate__(attributes, Attributes::Td)
			super
		end

		def template(**attributes)
			__validate__(attributes, Attributes::Template)
			super
		end

		def textarea(**attributes)
			__validate__(attributes, Attributes::Textarea)
			super
		end

		def tfoot(**attributes)
			__validate__(attributes, Attributes::Tfoot)
			super
		end

		def th(**attributes)
			__validate__(attributes, Attributes::Th)
			super
		end

		def thead(**attributes)
			__validate__(attributes, Attributes::Thead)
			super
		end

		def time(**attributes)
			__validate__(attributes, Attributes::Time)
			super
		end

		def title(**attributes)
			__validate__(attributes, Attributes::Title)
			super
		end

		def tr(**attributes)
			__validate__(attributes, Attributes::Tr)
			super
		end

		def track(**attributes)
			__validate__(attributes, Attributes::Track)
			super
		end

		def tt(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def u(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def ul(**attributes)
			__validate__(attributes, Attributes::Ul)
			super
		end

		def var(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end

		def video(**attributes)
			__validate__(attributes, Attributes::Video)
			super
		end

		def wbr(**attributes)
			__validate__(attributes, Attributes::Global)
			super
		end
	end
end
