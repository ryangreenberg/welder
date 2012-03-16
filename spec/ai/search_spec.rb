require 'spec_helper'

describe Welder::AI::Search do
  before do
    letters = <<-EOS
      abc
      def
      ghi
    EOS
    tiles = get_tiles_for_string(letters)
    @board = get_board_for_tiles(tiles)
    words = ['adh']
    @dictionary = Welder::Dictionary.new(words)
    @rules = Welder::Rules.new(:min_word_length => 3)
    @tile_generator = Welder::TileGenerator.new([['a', 1]])
    @game = Welder::Game.new(@board, @dictionary, @rules, @tile_generator)
  end

  describe "#move" do
    it "changes the provided board to form a word" do
      ai = Welder::AI::Search.new(@board, @dictionary)
      ai.move
      @board.to_s.should == "abc\ndef\nhgi"
    end
  end
end
