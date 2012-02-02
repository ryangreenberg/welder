require 'spec_helper'

describe Welder::Tile do
  describe "#to_s" do
    it "returns the tile's letter" do
      Welder::Tile.new("a").to_s.should == "a"
    end
  end

  describe "#value" do
    it "returns 1 for vowels" do
      Welder::Tile.new("a").value.should == 1
    end

    it "returns 2 for low-value consonants" do
      Welder::Tile.new("d").value.should == 2
    end

    it "returns 4 for mid-value consonants" do
      Welder::Tile.new("b").value.should == 4
    end

    it "returns 8 for high-value consontants" do
      Welder::Tile.new("z").value.should == 8
    end
  end
end