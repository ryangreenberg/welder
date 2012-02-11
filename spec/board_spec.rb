require 'spec_helper'

describe Welder::Board do
  it "has a coordinate system zero-indexed from the top-left" do
    letters = <<-EOS
      abcd
      efgh
      ijkl
      mnop
    EOS
    tiles = get_tiles_for_string(letters)
    board = get_board_for_tiles(tiles)

    tiles.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        board.get_tile(x, y).should == tiles[y][x]
      end
    end

    board.to_s.should == letters.gsub(/^\s*|\s*$/, '')
  end

  describe "#populate" do
    it "calls the provided block once for each space on the board" do
      board = Welder::Board.new(4)
      times_called = 0
      board.populate {|x, y| times_called += 1}
      times_called.should == 16
    end

    it "places the returned tile on the board at the yielded coordinates" do
      tiles = [
        Welder::Tile.new('a'),
        Welder::Tile.new('b'),
        Welder::Tile.new('c'),
        Welder::Tile.new('d')
      ]
      placed_tiles = []
      board = Welder::Board.new(2)

      board.populate do |x, y|
        tile = tiles.shift
        placed_tiles << [x, y, tile]
        tile
      end

      placed_tiles.size.should == 4
      placed_tiles.each do |x, y, tile|
        board.get_tile(x, y).should == tile
      end
    end
  end

  describe "#swap" do
    before do
      board_size = 3
      @board = Welder::Board.new(board_size)
      letters = "abcdefghi".split("")
      @board.populate do |x, y|
        Welder::Tile.new(letters.shift)
      end
      @center_tile = @board.get_tile(1, 1)
    end

    it "moves the tile up when direction is :north" do
      @board.swap(1, 1, :north)
      @board.get_tile(1, 0).should == @center_tile
    end

    it "moves the tile up-right when direction is :northeast" do
      @board.swap(1, 1, :northeast)
      @board.get_tile(2, 0).should == @center_tile
    end

    it "moves the tile right when direction is :east" do
      @board.swap(1, 1, :east)
      @board.get_tile(2, 1).should == @center_tile
    end

    it "moves the tile down-right when direction is :southeast" do
      @board.swap(1, 1, :southeast)
      @board.get_tile(2, 2).should == @center_tile
    end

    it "moves the tile down when direction is :south" do
      @board.swap(1, 1, :south)
      @board.get_tile(1, 2).should == @center_tile
    end

    it "moves the tile down-left when direction is :southwest" do
      @board.swap(1, 1, :southwest)
      @board.get_tile(0, 2).should == @center_tile
    end

    it "moves the tile left when direction is :west" do
      @board.swap(1, 1, :west)
      @board.get_tile(0, 1).should == @center_tile
    end

    it "moves the tile up-left when direction is :northwest" do
      @board.swap(1, 1, :northwest)
      @board.get_tile(0, 0).should == @center_tile
    end

    it "returns false when the swap would go off the board" do
      # Coordinates keyed to invalid moves from those coordinates on a 3x3 grid
      # Invalid options are listed in clockwise order
      invalid_moves_from_coords = {
        [0, 0] => [:sw, :w, :nw, :n, :ne],
        [1, 0] => [:nw, :n, :ne],
        [2, 0] => [:nw, :n, :ne, :e, :se],
        [0, 1] => [:sw, :w, :nw],
        [1, 1] => [],
        [2, 1] => [:ne, :e, :se],
        [0, 2] => [:se, :s, :sw, :w, :nw],
        [1, 2] => [:se, :s, :sw],
        [2, 2] => [:ne, :e, :se, :s, :sw]
      }

      invalid_moves_from_coords.each do |(x, y), invalid_moves|
        invalid_moves.each do |invalid_move|
          @board.swap(x, y, invalid_move).should be_false
        end
      end
    end
  end

  describe "#get_word" do
    before do
      @board = get_board_for_string <<-EOS
        abc
        def
        ghi
      EOS
    end

    it "returns the word of the specified length and orientation at the given position" do
      @board.get_word(0, 0, :horizontal, 3).to_s.should == "abc"
      @board.get_word(0, 2, :horizontal, 3).to_s.should == "ghi"
      @board.get_word(0, 0, :vertical, 3).to_s.should == "adg"
      @board.get_word(2, 0, :vertical, 3).to_s.should == "cfi"
    end

    it "sets the position of the word on the board" do
      word = @board.get_word(0, 2, :horizontal, 3)
      word.x.should == 0
      word.y.should == 2
    end

    it "sets the orientation of the word on the board" do
      word = @board.get_word(0, 2, :horizontal, 3)
      word.orientation.should == :horizontal
    end

    it "returns false if the specified row or colum doesn't exist" do
      @board.get_word(0, 3, :horizontal, 3).should == false
      @board.get_word(3, 0, :vertical, 3).should == false
      @board.get_word(3, 3, :horizontal, 3).should == false
      @board.get_word(3, 3, :vertical, 3).should == false
    end

    it "returns false if the specified length run off the board" do
      @board.get_word(0, 0, :horizontal, 4).should == false
      @board.get_word(0, 0, :vertical, 4).should == false
    end

    it "raises ArgumentError if an invalid orientation is provided" do
      lambda { @board.get_word(0, 0, :diagonal, 3) }.should raise_error(ArgumentError)
    end
  end

  describe "#remove_word" do
    it "removes the provided word from the board" do
      board = get_board_for_string <<-EOS
        abc
        def
        ghi
      EOS

      word = board.get_word(0, 0, :horizontal, 3)
      board.remove_word(word)
      board_without_word = <<-EOS.gsub(/^\s*|\s*$/, '')
        ...
        def
        ghi
      EOS
      board.to_s.should == board_without_word
    end
  end

  describe "#drop_tiles" do
    it "moves all tiles on board so that no tile has a blank space below/south of it" do
      letters = <<-EOS
        abcd
        ef..
        g.h.
        ....
      EOS
      tiles = get_tiles_for_string(letters)
      board = get_board_for_tiles(tiles)

      board.drop_tiles

      dropped_letters = <<-EOS.gsub(/^\s*|\s*$/, '')
        ....
        a...
        ebc.
        gfhd
      EOS
      board.to_s.should == dropped_letters
    end
  end
end
