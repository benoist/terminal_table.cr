class TerminalTable
  class Separator < Row
    def render(widths = column_widths, style = Style.new)
      arr_x = widths.map do |width|
        style.border_x * (width + style.padding_left + style.padding_right)
      end
      border_i = style.border_i
      border_i + arr_x.join(border_i) + border_i
    end
  end
end
