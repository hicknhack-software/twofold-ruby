module Twofold
  class Parser < Temple::Parser

    def call(input)
      result = [:multi]

      @lines = input.split(/\r?\n/)
      @line_no = 0
      @stack = [result]

      parse_line while next_line

      result
    end

    def next_line
      if @lines.empty?
        @line = nil
      else
        @line = @lines.shift
        @line_no += 1
      end
    end

    def parse_line
      line = @line.lstrip

      case line[0]
      when '\\'
        indented line[1..] do |text|
          @stack.last << [:twofold, :interpolate, text]
        end
      when '|'
        indented line[1..] do |text|
          @stack.last << [:twofold, :interpolate, text]
        end
        @stack.last << [:twofold, :newline]
      when '='
        indented line[1..] do |code|
          @stack.last << [:code, code]
        end
      when nil
        # empty line
      else
        @stack.last << [:code, line]
      end
      @stack.last << [:newline]
    end

    def indented(str)
      indent = str[/\A\s*/]
      @stack.push([:multi])
      yield str.lstrip
      inner = @stack.pop
      @stack.last << [:twofold, :indented, indent, inner]
    end

  end
end