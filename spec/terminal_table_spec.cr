require "./spec_helper"

describe TerminalTable do
  it "creates a table with emptys rows and style" do
    table = TerminalTable.new

    table.rows.size.should eq 0
  end

  it "should select columns" do
    table = TerminalTable.new
    table << ["foo", "bar"]
    table << ["big foo", "big foo bar"]
    table.column(1).should eq ["bar", "big foo bar"]
  end

  it "returns the number of columns" do
    table = TerminalTable.new
    table << ["foo", "bar"]
    table << ["big foo", "big foo bar"]
    table.number_of_columns.should eq 2
  end

  it "separators dont count as rows" do
    table = TerminalTable.new
    table << ["a", 1]
    table.add_separator
    table << ["b", 2]
    table.rows.size.should eq 2
  end

  it "renders an empty table" do
    table = TerminalTable.new
    table.render.should eq <<-EOF
    ++
    ++
    EOF
  end

  it "should render properly" do
    table = TerminalTable.new
    table.headings = ["Char", "Num"]
    table << ["a", 1]
    table << ["b", 2]
    table << ["c", 3]
    table.render.should eq <<-EOF
    +------+-----+
    | Char | Num |
    +------+-----+
    | a    | 1   |
    | b    | 2   |
    | c    | 3   |
    +------+-----+
    EOF
  end

  it "renders tables with multiline cells" do
    table = TerminalTable.new
    table.headings = ["Char", "Num"]
    table << ["a", 1]
    table << ["b\nc", 2]
    table << ["d", 3]
    table.render.should eq <<-EOF
    +------+-----+
    | Char | Num |
    +------+-----+
    | a    | 1   |
    | b    | 2   |
    | c    |     |
    | d    | 3   |
    +------+-----+
    EOF
  end

  it "renders tables with multiline cells" do
    table = TerminalTable.new
    table.headings = ["Char", "Num"]
    table.separate_rows = true
    table << ["a", 1]
    table << ["b\nc", 2]
    table << ["d", 3]
    table.render.should eq <<-EOF
    +------+-----+
    | Char | Num |
    +------+-----+
    | a    | 1   |
    +------+-----+
    | b    | 2   |
    | c    |     |
    +------+-----+
    | d    | 3   |
    +------+-----+
    EOF
  end
end
