class Welder::Game
  def initialize(board_size, dictionary)
    @dictionary = dictionary
    @board = Welder::Board.new(board_size)
  end

  def populate
    weighted_letters = ("aeiou" * 8 + "dlnrst" * 4 + "bcfghkmpwxy" * 2 + "jqvz").split("")
    @board.size.times do |i|
      @board.size.times do |j|
        @board.set_tile(i, j, weighted_letters.choice)
      end
    end
  end

  def detect_words
    possible_words = @board.possible_words
    valid_words = possible_words.select do |word|
      @dictionary.include?(word)
    end
  end
end