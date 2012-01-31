class Welder::Board
  def initialize(size = 8)
    @size = size
    @board = size.times.map { Array.new(size) }
  end

  def get_tile(x, y)
    @board[x][y]
  end

  def set_tile(x, y, tile)
    @board[x][y] = tile
  end

  def possible_words(min_word_length=4)
    words = []

    each_row_and_col do |row|
      0.upto(@size - min_word_length) do |start_char|
        (start_char + min_word_length).upto(@size) do |end_char|
          words.push(row.slice(start_char...end_char).join)
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
    each_row {|row| yield row }
    each_col {|col| yield col }
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
    @board.length
  end
end