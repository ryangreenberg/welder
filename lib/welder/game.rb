class Welder::Game
  attr_reader :board

  def initialize(board_size, dictionary)
    @dictionary = dictionary
    @board = Welder::Board.new(board_size)
  end

  def swap(x1, y1, direction)
    x2, y2 = get_neighbor(x1, y1, direction)
    return false if invalid_dest_coords?(x2, y2)

    @tile1 = @board.get_tile(x1, y1)
    @tile2 = @board.get_tile(x2, y2)
    @board.set_tile(x2, y2, @tile1)
    @board.set_tile(x1, y1, @tile2)
    true
  end

  def populate
    weighted_letters = ("aeiou" * 8 + "dlnrst" * 4 + "bcfghkmpwxy" * 2 + "jqvz").split("")
    @board.size.times do |i|
      @board.size.times do |j|
        @board.set_tile(i, j, Welder::Tile.new(weighted_letters.choice))
      end
    end
  end

  def detect_words
    possible_words = @board.possible_words
    valid_words = possible_words.select do |word|
      @dictionary.include?(word.to_s)
    end
  end

  private

  def get_neighbor(x, y, direction)
    case direction
      when :north,     :n,  :up         then [x, y - 1]
      when :south,     :s,  :down       then [x, y + 1]
      when :east,      :e,  :right      then [x + 1, y]
      when :west,      :w,  :left       then [x - 1, y]
      when :northeast, :ne, :up_right   then [x + 1, y - 1]
      when :northwest, :nw, :up_left    then [x - 1, y - 1]
      when :southeast, :se, :down_right then [x + 1, y + 1]
      when :southwest, :sw, :down_left  then [x - 1, y + 1]
    end
  end

  def invalid_dest_coords?(x, y)
    x < 0 || y < 0 || x >= @board.size || y >= @board.size
  end
end