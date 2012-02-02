class Welder::Word
  VALID_ORIENTATIONS = [:horizontal, :vertical].freeze

  def initialize(tiles, x, y, orientation)
    @tiles = tiles
    @start = [x, y]
    if VALID_ORIENTATIONS.include?(orientation)
      @orientation = orientation
    else
      raise ArgumentError, "invalid orientation"
    end
  end

  def to_s
    @tiles.map{|tile| tile.to_s}.join("")
  end

  def score
    @tiles.inject(0) {|sum, tile| sum + tile.value } * @tiles.length
  end
  
  def length
    @tiles.length
  end
  alias :size :length
  alias :count :length
end