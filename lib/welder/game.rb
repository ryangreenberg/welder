require 'forwardable'

class Welder::Game
  extend Forwardable

  attr_reader :board
  def_delegator :board, :swap

  def initialize(board_size, dictionary, tile_generator)
    @board = Welder::Board.new(board_size)
    @dictionary = dictionary
    @tile_generator = tile_generator
  end

  def populate
    @board.size.times do |i|
      @board.size.times do |j|
        @board.set_tile(i, j, Welder::Tile.new(@tile_generator.get_tile))
      end
    end
  end

  def detect_words
    possible_words = @board.possible_words
    valid_words = possible_words.select do |word|
      @dictionary.include?(word.to_s)
    end
  end
end