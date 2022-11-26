class Board
  attr_accessor :board
  attr_reader :board_colors
  @@board_colors = %w(blue green yellow red orange purple)

  def initialize(shield)
    @board = {shield: shield}
    @guesses = 0
  end
  
  def self.print_colors
    puts "-------------------------------------------------"
    print "|"
    @@board_colors.each do |color|
      print " #{color.capitalize} |"
    end
    puts "\n-------------------------------------------------"
  end
end

# board = Board.new(%i[blue red green green])

# print board.board[:shield]
