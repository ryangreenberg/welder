require 'spec_helper'

describe Welder::Game do
  before do
    words = ['abc', 'def', 'ghi']
    @dictionary = Welder::Dictionary.new(words)
    @board_size = 4
  end

  describe "#populate" do
    it "fills the board with tiles" do
      game = Welder::Game.new(@board_size, @dictionary)
      game.board.each_row do |row|
        row.compact.should be_empty
      end
      game.populate
      game.board.each_row do |row|
        row.each do |cell|
          cell.should be_a(Welder::Tile)
        end
      end
    end
  end

  describe "#swap" do
    before do
      board_size = 3
      @game = Welder::Game.new(board_size, @dictionary)
      @game.populate
      @center_tile = @game.board.get_tile(1, 1)
    end

    it "moves the tile up when direction is :north" do
      @game.swap(1, 1, :north)
      @game.board.get_tile(1, 0).should == @center_tile
    end

    it "moves the tile up-right when direction is :northeast" do
      @game.swap(1, 1, :northeast)
      @game.board.get_tile(2, 0).should == @center_tile
    end

    it "moves the tile right when direction is :east" do
      @game.swap(1, 1, :east)
      @game.board.get_tile(2, 1).should == @center_tile
    end

    it "moves the tile down-right when direction is :southeast" do
      @game.swap(1, 1, :southeast)
      @game.board.get_tile(2, 2).should == @center_tile
    end

    it "moves the tile down when direction is :south" do
      @game.swap(1, 1, :south)
      @game.board.get_tile(1, 2).should == @center_tile
    end

    it "moves the tile down-left when direction is :southwest" do
      @game.swap(1, 1, :southwest)
      @game.board.get_tile(0, 2).should == @center_tile
    end

    it "moves the tile left when direction is :west" do
      @game.swap(1, 1, :west)
      @game.board.get_tile(0, 1).should == @center_tile
    end

    it "moves the tile up-left when direction is :northwest" do
      @game.swap(1, 1, :northwest)
      @game.board.get_tile(0, 0).should == @center_tile
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
          @game.swap(x, y, invalid_move).should be_false
        end
      end
    end
  end
end