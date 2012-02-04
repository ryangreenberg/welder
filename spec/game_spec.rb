require 'spec_helper'

describe Welder::Game do
  before do
    words = ['abc', 'def', 'ghi']
    @dictionary = Welder::Dictionary.new(words)
    @board_size = 4
  end

  describe "#populate" do
    it "fills the board with tiles" do
      game = Welder::Game.new(@board_size, @dictionary)
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