class Board
  attr_accessor :board
  attr_accessor :guesses
  @@board_colors = %w(blue green yellow red orange purple)

  def initialize(shield)
    @board = {shield: shield}
    @guesses = 1 
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
        print "|"

        print "#{row_content["feedback"][0]}  #{row_content["feedback"][1]} || "
        
        row_content["guess"].each_with_index do |guess_value, spot|
            if spot == 0
                print "#{guess_value.capitalize} "
            else
                print "| #{guess_value.capitalize} "
            end
        end

        print "|| "

        print "#{row_content["feedback"][2]}  #{row_content["feedback"][3]}"

        print "|"
        print "\n----------------- "
        print "------------------------------------------------- "
        print "-----------------\n\n"
      end
    end
  end
end

# board = Board.new(%i[blue red green green])

# print board.board[:shield]
