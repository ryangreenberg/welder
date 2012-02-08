class Welder::TileGenerator
  def initialize(weighted_items)
    @tiles = Welder::WeightedArray.new(weighted_items)
  end
  
  def get_tile
    Welder::Tile.new(@tiles.sample)
  end
  
  def get_tiles(num)
    num.times.map { get_tile }
  end
end