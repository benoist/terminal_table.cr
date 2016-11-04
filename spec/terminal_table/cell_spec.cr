require "../spec_helper"

class TerminalTable
  describe Cell do
    it "assigns the value" do
      [nil, true, 1, 1_u32, 1.1_f32, 1.1_f64, "", [""] of CellValue, {"" => ""} of String => CellValue].each do |value|
        Cell.new(value).value.should eq value
      end
    end

    it "renders the cell" do
      cell = Cell.new("barrissimo\n" + "foo".colorize(:yellow).to_s)

      cell.value.should eq "barrissimo\n" + "foo".colorize(:yellow).to_s
      cell.lines.should eq ["barrissimo", "foo".colorize(:yellow).to_s]
      cell.render(0).should eq " barrissimo "
    end

    it "renders an empty line if the line number is larger than the value contains" do
      cell = Cell.new("foo")
      cell.render(1, width: 5).should eq "       "
    end

    it "should allow colorized content" do
      cell = Cell.new("foo".colorize(:red).to_s)
      cell.value.should eq "\e[31mfoo\e[0m"
      cell.value_for_column_width_recalc.should eq "foo"
      cell.render.should eq " \e[31mfoo\e[0m "
    end

    it "should render padding properly" do
      cell = Cell.new("foo")
      cell.value.should eq "foo"
      cell.render(style: Style.new(padding_right: 3)).should eq " foo   "
    end

    it "should not ignore pipe characters" do
      cell = Cell.new("f|o|o")
      cell.value.should eq "f|o|o"
      cell.value_for_column_width_recalc.should eq "f|o|o"
      cell.render.should eq " f|o|o "
    end
  end
end
