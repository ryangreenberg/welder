require 'spec_helper'

describe Welder::Word do
  before do
    @tiles = [
      Welder::Tile.new('a'), # value 1
      Welder::Tile.new('b'), # value 4
      Welder::Tile.new('c'), # value 4
      Welder::Tile.new('d')  # value 2
    ]
  end

  describe "#initialize" do
    it "raises an ArgumentError if orientation is not :horizontal or :vertical" do
      word = lambda { Welder::Word.new(@tiles, 0, 0, :horizontal) }.should_not raise_error
      word = lambda { Welder::Word.new(@tiles, 0, 0, :vertical) }.should_not raise_error
      word = lambda { Welder::Word.new(@tiles, 0, 0, :diagonal) }.should raise_error(ArgumentError)
    end
  end

  describe "#to_s" do
    it "returns a string of letters based on the tiles" do
      word = Welder::Word.new(@tiles, 0, 0, :horizontal)
      word.to_s.should == 'abcd'
    end
  end

  describe "#score" do
    it "returns the sum of the word's tiles multiplied by the number of tiles" do
      word = Welder::Word.new(@tiles, 0, 0, :horizontal)
      word.score.should == ((1 + 4 + 4 + 2) * 4)
    end
  end
  
  describe "#length, #size, #count" do
    it "returns the number of tiles in the word" do
      word = Welder::Word.new(@tiles, 0, 0, :horizontal)
      word.length.should == @tiles.length
      word.size.should == @tiles.length
      word.count.should == @tiles.length
    end
  end
end