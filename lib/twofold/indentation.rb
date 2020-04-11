module Twofold
  class Indentation < Filter
    define_options indent: "@_indent", # stack of indentation strings
                   indented: "@_indented" # is current line already indented?

    def initialize(opts = {})
      super
      @indent = options[:indent]
      @indented = options[:indented]
    end

    def on_twofold_indented(indent, inner)
      block = [:multi]
      block << [:code, "(#{@indent} ||= []) << '#{indent}'"]
      block << compile(inner)
      block << [:code, "#{@indent}.pop"]
      block
    end

    def on_twofold_newline
      [:multi,
       [:code, "#{@indented} = false"],
       [:static, "\n"]
      ]
    end

    def on_static(string)
      if string.empty?
        [:static, string]
      else
        [:multi,
         ensure_indent,
         [:static, string]
        ]
      end
    end

    def on_dynamic(ruby)
      [:multi,
       [:capture, 'tmp', [:dynamic, ruby]],
       [:if,
        'not tmp.nil? and not tmp.empty?',
        [:block,
         'tmp.split(/(?<=\n)/).each do |line|',
         [:multi,
          ensure_indent,
          [:dynamic, "line"],
          [:if,
           "line[-1] == #{'"\n"'}",
           [:code, "#{@indented} = false"]
          ]
         ]
        ]
       ]
      ]
    end

    private

    def ensure_indent
      [:if,
       "not #{@indented}",
       [:multi,
        [:code, "#{@indented} = true"],
        [:dynamic, "(#{@indent} ||= [])*''"]
       ]
      ]
    end

  end
end
