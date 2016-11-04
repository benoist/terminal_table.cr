require "../spec_helper"

class TerminalTable::Table
  describe Row do
    it "converts the values to cells" do
      separator = Separator.new
      separator.render([1, 3, 2]).should eq "+---+-----+----+"
    end
  end
end
