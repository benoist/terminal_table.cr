class TerminalTable
  class Row
    getter cells

    def self.new(items : Array(CellValue))
      new(items.map { |item| Cell.new(item) })
    end

    def initialize(@cells : Array(Cell) = [] of Cell)
    end

    def <<(cell_value : CellValue)
      cells << Cell.new(cell_value)
    end

    def <<(cell : Cell)
      cells << cell
    end

    def height
      cells.map { |c| c.lines.size }.max || 0
    end

    def column_widths
      cells.map { |c| c.value_for_column_width_recalc.size }
    end

    def number_of_columns
      cells.size
    end

    def render(widths = column_widths, style = Style.new, alignment = :left)
      y = style.border_y
      (0...height).to_a.map do |line|
        y + cells.map_with_index do |cell, index|
          cell.render(line, widths[index], style: style)
        end.join(y) + y
      end.join("\n")
    end
  end
end
