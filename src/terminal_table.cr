require "./terminal_table/*"

class TerminalTable
  alias CellValue = Nil | Bool | Int::Signed | Int::Unsigned | Float32 | Float64 | String | Array(CellValue) | Hash(String, CellValue)

  getter rows : Array(Row)
  getter style : Style
  property headings : Array(Row)

  getter! column_widths : Array(Int32)

  def initialize(@rows = [] of Row)
    @style = Style.new
    @headings = [] of Row
  end

  def headings=(cell_values : Array(CellValue))
    @headings = [Row.new(cell_values)]
  end

  def add_separator
    @rows << Separator.new
  end

  def separate_rows=(separate_rows)
    @style.separate_rows = separate_rows
  end

  def <<(cell_values : Array(CellValue))
    @rows << Row.new(cell_values)
  end

  def <<(row : Row)
    @rows << row
  end

  def column(n)
    rows.map(&.cells[n].value)
  end

  def number_of_columns
    headings_with_rows.max_by(&.number_of_columns).number_of_columns
  end

  def rows
    @rows.reject(&.is_a?(Separator))
  end

  def column_widths
    return [] of Int32 if headings_with_rows.size == 0

    @column_widths ||= begin
      column_widths = Array(Int32).new(number_of_columns, 0)

      headings_with_rows.each do |row|
        row.column_widths.each_with_index do |width, index|
          column_widths[index] = {column_widths[index], width}.max
        end
      end

      column_widths
    end
  end

  def render
    separator = Separator.new
    buffer = [separator] of Row

    @headings.each do |row|
      buffer << row
      buffer << separator
    end

    @rows.each do |row|
      buffer << row
      buffer << Separator.new if @style.separate_rows
    end

    buffer << separator unless @style.separate_rows

    buffer.map do |r|
      style.margin_left + r.render(column_widths).rstrip
    end.join("\n")
  end

  private def headings_with_rows
    @headings + rows
  end
end
