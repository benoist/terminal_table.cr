require "../src/terminal_table"

table = TerminalTable.new
table.headings = ["Char", "Num"]
table << ["a", 1]
table << ["b", 2]
table << ["c", 3]
puts table.render
