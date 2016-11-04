class TerminalTable
  class Cell
    getter value : CellValue

    def initialize(@value : CellValue = nil)
    end

    def lines
      @value.to_s.split(/\n/)
    end

    def align(value, alignment, width)
      case alignment
      when :right
        value.rjust(width)
      else
        value.ljust(width)
      end
    end

    def value_for_column_width_recalc
      lines.map { |s| escape(s) }.max_by { |s| s.size }
    end

    def render(line = 0, width = value_for_column_width_recalc.size, style = Style.new, alignment = :left)
      left = " " * style.padding_left
      right = " " * style.padding_right

      if line < lines.size
        display_width = escape(lines[line]).size
        render_width = lines[line].to_s.size - display_width + (width + style.padding_left + style.padding_right)

        align("#{left}#{lines[line]}#{right}", alignment, render_width)
      else
        left + " " * width + right
      end
    end

    def escape(line)
      line.to_s.gsub(/\x1b(\[|\(|\))[;?0-9]*[0-9A-Za-z]/, "")
               .gsub(/\x1b(\[|\(|\))[;?0-9]*[0-9A-Za-z]/, "")
               .gsub(/(\x03|\x1a)/, "")
    end
  end
end
