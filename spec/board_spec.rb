require 'spec_helper'

describe Welder::Board do
  it "has a coordinate system zero-indexed from the top-left" do
    letters = <<-EOS.gsub(/^\s*/, '').strip
      abcd
      efgh
      ijkl
      mnop
    EOS
    board = Welder::Board.new(4)
    rows = letters.split("\n")
    rows.each_with_index do |chars, y|
      chars.split("").each_with_index do |char, x|
        tile = Welder::Tile.new(char)
        board.set_tile(x, y, tile)
      end
    end
    board.to_s.should == letters
  end
end