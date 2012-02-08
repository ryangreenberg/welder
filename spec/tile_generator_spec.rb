require 'spec_helper'

describe Welder::TileGenerator do
  describe "#get_tile" do
    it "returns a Welder::Tile" do
      tile_generator = Welder::TileGenerator.new([['a', 1]])
      tile_generator.get_tile.should be_a(Welder::Tile)
    end
  end
  
  describe "#get_tiles" do
    it "returns the specified number of Welder::Tiles" do
      num_tiles_to_generate = 10
      tile_generator = Welder::TileGenerator.new([['a', 1]])
      tiles = tile_generator.get_tiles(num_tiles_to_generate)
      tiles.size.should == num_tiles_to_generate
      tiles.each {|t| t.should be_a(Welder::Tile) }
    end
  end
end