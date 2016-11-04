require "../spec_helper"

class TerminalTable::Table
  describe Row do
    it "converts the values to cells" do
      row = Row.new(["a", "b", "c"] of CellValue)
      cell = row.cells.first
      cell.value.should eq "a"
    end

    it "should calculate height for multiline cells" do
      row = Row.new ["a", "b", "c\nb"]
      row.height.should eq 2
    end

    it "renders the row" do
      row = Row.new ["a", "b", "c\nb"]
      row.render.should eq <<-ROW
      | a | b | c |
      |   |   | b |
      ROW
    end

    it "can add new cell values to the row" do
      row = Row.new
      row << "a"
      row.cells.first.value.should eq "a"
    end

    it "can add new cells to the row" do
      row = Row.new
      row << Cell.new("a")
      row.cells.first.value.should eq "a"
    end
  end
end
