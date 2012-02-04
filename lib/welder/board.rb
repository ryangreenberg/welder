class Welder::Board
  def initialize(size = 8)
    @size = size
    @board = size.times.map { Array.new(size) }
  end

  def get_tile(x, y)
    @board[y][x]
  end

  def set_tile(x, y, tile)
    @board[y][x] = tile
  end

  def swap(x1, y1, direction)
    x2, y2 = get_neighbor(x1, y1, direction)
    return false if invalid_dest_coords?(x2, y2)

    @tile1 = get_tile(x1, y1)
    @tile2 = get_tile(x2, y2)
    set_tile(x2, y2, @tile1)
    set_tile(x1, y1, @tile2)
    true
  end

  def possible_words(min_word_length=4)
    words = []

    each_row_and_col do |row_or_col, orientation|
      0.upto(@size - min_word_length) do |start_char|
        (start_char + min_word_length).upto(@size) do |end_char|
          tiles = row_or_col.slice(start_char...end_char)
          word = Welder::Word.new(tiles, start_char, end_char, orientation)
          words.push(word)
        end
      end
    end

    words
  end

  module Iterators
    def each_row
      @board.each {|row| yield row }
    end

    def each_col
      cols.each {|col| yield col }
    end

    def each_col_with_index
      cols.each_with_index {|col, index| yield col, index }
    end

    def each_row_and_col
      each_row {|row| yield row, :horizontal }
      each_col {|col| yield col, :vertical }
    end

    def cols
      num_cols = @board[0].length
      num_rows = @board.length
      num_cols.times.map {|i| @board.map{|row| row[i]}}
    end

    def populate
      num_cols = @board[0].length
      num_rows = @board.length

      num_rows.times do |y|
        num_cols.times do |x|
          tile = yield x, y
          set_tile(x, y, tile)
        end
      end
    end
  end
  include Iterators

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