require 'spec_helper'

describe Welder::Game do
  before do
    @board_size = 4
    words = ['abc', 'def', 'ghi']
    @dictionary = Welder::Dictionary.new(words)
    @rules = Welder::Rules.new(:min_word_length => 3)
    @tile_generator = Welder::TileGenerator.new([['a', 1]])
  end

  describe "#populate" do
    it "fills the board with tiles" do
      game = Welder::Game.new(@board_size, @dictionary, @rules, @tile_generator)
      game.board.each_row do |row|
        row.reject {|tile| tile.empty? }.should be_empty
      end
      game.populate
      game.board.each_row do |row|
        row.each do |cell|
          cell.should be_a(Welder::Tile)
        end
      end
    end
  end

  describe "#populate_empty" do
    it "fills only empty tiles on the board" do
      game = Welder::Game.new(@board_size, @dictionary, @rules, @tile_generator)
      existing_tile = Welder::Tile.new('a')
      game.board.set_tile(0, 0, existing_tile)
      game.populate_empty

      game.board.each_row do |row|
        row.each do |cell|
          cell.should be_a(Welder::Tile)
          cell.should_not be_empty
        end
      end
      game.board.get_tile(0, 0).should == existing_tile
    end
  end

  describe "#ensure_no_valid_words" do
    it "changes the board so that valid_words_on_board is an empty array" do
      game = Welder::Game.new(@board_size, @dictionary, @rules, @tile_generator)

      # Place valid words on the board
      game.board.set_tile(0, 0, 'a')
      game.board.set_tile(0, 1, 'b')
      game.board.set_tile(0, 2, 'c')

      game.board.set_tile(1, 0, 'd')
      game.board.set_tile(2, 0, 'e')
      game.board.set_tile(3, 0, 'f')

      game.valid_words_on_board.size.should == 2

      game.ensure_no_valid_words

      game.valid_words_on_board.size.should == 0
    end
  end

  describe "#add_to_score" do
    it "adds the score of the word to the game score" do
      game = Welder::Game.new(@board_size, @dictionary, @rules, @tile_generator)
      game.populate
      game.score.should == 0
      word = game.board.get_word(0, 0, :horizontal, 4)
      game.add_to_score([ word ])
      game.score.should == word.score
    end

    it "adds the multiple_word_bonus for each word in excess of one" do
      game = Welder::Game.new(@board_size, @dictionary, @rules, @tile_generator)
      game.populate
      game.score.should == 0
      words = [
        game.board.get_word(0, 0, :horizontal, 4),
        game.board.get_word(0, 0, :vertical, 4),
        game.board.get_word(0, 1, :horizontal, 4)
      ]
      words_score = words.inject(0){ |sum, word| sum += word.score }
      multiple_word_bonus = @rules.multiple_word_bonus * 2 # 2 extra words

      game.add_to_score(words)
      game.score.should == words_score + multiple_word_bonus
    end
  end
end
