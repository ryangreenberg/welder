class Welder::Game
  attr_reader :board, :score

  def initialize(board_size, dictionary, rules, tile_generator)
    @board = Welder::Board.new(board_size)
    @dictionary = dictionary
    @rules = rules
    @tile_generator = tile_generator

    @level = 1
    @swaps = rules.starting_swaps_for_level(@level)
    @score = 0
  end

  def populate
    @board.populate do |x, y|
      Welder::Tile.new(@tile_generator.get_tile)
    end
  end

  def valid_words_on_board
    possible_words = @board.possible_words
    possible_words.select do |word|
      @dictionary.include?(word.to_s)
    end
  end

  def remove_valid_words
    words_to_remove = valid_words_on_board
    words_to_remove.each do |word|
      @board.remove_word(word)
    end
    words_to_remove
  end

  def swap(x, y, direction)
    @board.swap(x, y, directory)
    remove_valid_words
    @board.drop_tiles
  end
end
