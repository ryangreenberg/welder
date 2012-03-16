module Welder
  module AI
    class Search
      def initialize(board, dictionary)
        @board = board
        @dictionary = dictionary
      end

      def move
        all_possible_moves = @board.all_possible_moves
        all_possible_moves.each do |move|
          board = Marshal.load(Marshal.dump(@board))
          board.swap(*move)
          possible_words = board.possible_words(3).map{|w| w.to_s}

          possible_words.each do |possible_word|
            return @board.swap(*move) if @dictionary.include?(possible_word)
          end
        end
      end
    end
  end
end