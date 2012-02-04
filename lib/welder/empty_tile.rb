class Welder::EmptyTile < Welder::Tile
  def initialize
    letter = '.'
    super(letter)
  end

  def value
    0
  end

  def empty?
    true
  end
end