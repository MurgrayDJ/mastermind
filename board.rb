class Board
  attr_accessor :board
  @@board_colors = %w(blue green yellow red orange purple)

  def initialize(shield)
    @board = {shield: shield}
    @guesses = 0
  end

  def self.board_colors
    @@board_colors
  end
  
  def self.print_colors
    puts "-------------------------------------------------"
    print "|"
    @@board_colors.each do |color|
      print " #{color.capitalize} |"
    end
    puts "\n-------------------------------------------------"
  end

  def print_board
    board.each do |row_name, row_content|
      unless row_name == :shield
        print "----------------- "
        print "------------------------------------------------- "
        print "-----------------\n"

        print "#{row_name[feedback1][0]}  #{row_name[feedback1][1]} || "
        
        row_name[guess].each do |guess_value|
          "#{guess_value} "
        end

        print "|| "

        print "#{row_name[feedback2][0]}  #{row_name[feedback2][1]}"


        print "----------------- "
        print "------------------------------------------------- "
        print "-----------------\n"
      end
    end
  end
end

# board = Board.new(%i[blue red green green])

# print board.board[:shield]
