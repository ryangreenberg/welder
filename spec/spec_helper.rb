require 'welder'

def get_board_for_tiles(tiles_grid)
  board = Welder::Board.new(tiles_grid.size)

  tiles_grid.each_with_index do |row, y|
    row.each_with_index do |tile, x|
      board.set_tile(x, y, tile)
    end
  end

  board
end

def get_tiles_for_string(str)
  # Strip leading and trailing whitespace so board can be
  # provided as a normal-looking heredoc
  str = str.gsub(/^\s*|\s*$/, '')
  str.split("\n").map do |row|
    row.split("").map do |char|
      char == '.' ? Welder::EmptyTile.new : Welder::Tile.new(char)
    end
  end
end