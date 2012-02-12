require 'spec_helper'

describe Welder::Game do
  before do
    @board_size = 4
    words = ['abc', 'def', 'ghi']
    @dictionary = Welder::Dictionary.new(words)
    @tile_generator = Welder::TileGenerator.new([['a', 1]])
  end

  describe "#populate" do
    it "fills the board with tiles" do
      game = Welder::Game.new(@board_size, @dictionary, @tile_generator)
      game.board.each_row do |row|
        row.compact.should be_empty
      end
      game.populate
      game.board.each_row do |row|
        row.each do |cell|
          cell.should be_a(Welder::Tile)
        end
      end
    end
  end
end
