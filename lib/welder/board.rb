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

  def each_row
    @board.each {|row| yield row }
  end

  def each_col
    cols.each {|col| yield col }
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

  def to_s
    @board.map {|row| row.join("")}.join("\n")
  end

  def size
    @size
  end
end