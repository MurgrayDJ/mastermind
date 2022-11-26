class Board
  attr_accessor :board
  attr_reader :board_colors
  @@board_colors = %w(blue green yellow red orange purple)

  def initialize(shield)
    @board = {shield: shield}
    @guesses = 0
  end
  
  def self.print_colors
    @@board_colors.each do |color|
      print "#{color} "
    end
    puts ":"
  end

  def set_shield
    
  end
end

# board = Board.new(%i[blue red green green])

# print board.board[:shield]
