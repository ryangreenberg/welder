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
      @tile_generator.get_tile
    end
  end

  def populate_empty
    @board.populate do |x, y|
      if @board.get_tile(x, y).empty?
        @tile_generator.get_tile
      else
        false
      end
    end
  end

  def valid_words_on_board
    possible_words = @board.possible_words(@rules.min_word_length)
    possible_words.select do |word|
      @dictionary.include?(word.to_s)
    end
  end

  def remove_valid_words
    # TODO Detect words entirely contained by other words
    valid_words_on_board.each do |word|
      @board.remove_word(word)
    end
  end

  def ensure_no_valid_words
    while valid_words_on_board.size > 0
      remove_valid_words
      populate_empty
    end
  end

  def swap(x, y, direction)
    if @board.swap(x, y, directory)
      @swaps -= 1
      add_to_score(remove_valid_words)
      @board.drop_tiles
    end
  end

  def add_to_score(words)
    @score += words.inject(0) {|sum, word| sum += word.score}
    @score += (words.size - 1) * @rules.multiple_word_bonus
  end
end
