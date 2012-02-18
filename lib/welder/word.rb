class Welder::Word
  attr_reader :tiles, :x, :y, :orientation

  def initialize(tiles, x, y, orientation)
    unless Welder::Constants::VALID_ORIENTATIONS.include?(orientation)
      raise ArgumentError, "invalid orientation '#{orientation}'"
    end

    @tiles = tiles
    @x, @y = x, y
    @orientation = orientation
  end

  def to_s
    @tiles.map{|tile| tile.to_s}.join("")
  end

  def score
    @tiles.inject(0) {|sum, tile| sum += tile.value } * @tiles.length
  end

  def length
    @tiles.length
  end
  alias :size :length
  alias :count :length
end
