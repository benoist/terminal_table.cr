class TerminalTable
  class Style
    getter border_x
    getter border_y
    getter border_i

    getter padding_left
    getter padding_right

    getter margin_left

    getter width : Int32?
    getter alignment : Symbol?

    property separate_rows

    def initialize(@border_x = "-",
                   @border_y = "|",
                   @border_i = "+",
                   @padding_left = 1,
                   @padding_right = 1,
                   @margin_left = "",
                   @width = nil,
                   @alignment = nil, @separate_rows = false)
    end
  end
end
