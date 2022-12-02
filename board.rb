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
        print "-----------------"
        print "  -----------------------------------------------  "
        print "-----------------\n"
        print "|"

        print_keypeg_or_space(row_content["key_pegs"][0])
        print_keypeg_or_space(row_content["key_pegs"][1])
        
        print "||"
        
        row_content["guess"].each_with_index do |code_peg, spot|
            if spot == 0
                print "#{code_peg.capitalize.center(11, " ")}"
            else
                print "|#{code_peg.capitalize.center(11, " ")}"
            end
        end

        print "||"
        
        print_keypeg_or_space(row_content["key_pegs"][2])
        print_keypeg_or_space(row_content["key_pegs"][3])

        print "|"
        print "\n-----------------"
        print "  -----------------------------------------------  "
        print "-----------------\n"
      end
    end
    print "\n"
  end

  def print_keypeg_or_space(keypeg_spot)
    if keypeg_spot.nil?
      print " " * 8
    else
      print "#{keypeg_spot.center(8, " ")}"
    end
  end
end

# board = Board.new(%i[blue red green green])

# print board.board[:shield]
