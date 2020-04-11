module Twofold
  class Interpolation < Filter
    # Works like Temple::Filters::StringSplitter but does not require ripper
    def on_twofold_interpolate(input)
      # Interpolate ruby code in text (#{variable}).
      # Split the text into multiple dynamic and static parts.
      block = [:multi]
      string = input
      begin
        case string
        when /\A\\#\{/
          # Escaped interpolation
          block << [:static, '#{']
          string = $'
        when /\A#\{((?>[^{}]|(\{(?>[^{}]|\g<1>)*\}))*)\}/
          # Interpolation
          string, code = $', $1
          escape = code !~ /\A\{.*\}\Z/
          block << [:dynamic, escape ? code : code[1..-2]]
        when /\A([#\\]?[^#\\]*([#\\][^\\#\{][^#\\]*)*)/
          # Static text
          block << [:static, $&]
          string = $'
        end
      end until string.empty?
      block
    end
  end
end
