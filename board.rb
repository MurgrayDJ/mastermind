

class Board
    attr_accessor :board
    
    def initialize(shield)
        @board = {
            :shield => shield
        }

        @guesses = 0
    end
end


board = Board.new([:blue, :red, :green, :green])

print board.board[:shield]