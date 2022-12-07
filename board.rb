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

  def print_shield
    print_line(:top_line)
    print_row_content([nil,nil,nil,nil], @board[:shield])
    print_line(:bottom_line)
  end

  def print_board
    board.each do |row_name, row_content|
      unless row_name == :shield
        print_line(:top_line)
        print_row_content(row_content["key_pegs"], row_content["guess"])
        print_line(:bottom_line)
      end
    end
    print "\n"
  end

  private
  def print_row_content(key_peg_array, code_array)
    print_keypeg_or_space(key_peg_array[0])
    print_keypeg_or_space(key_peg_array[1])
    
    print "||"
    
    print_code(code_array)

    print "||"
    
    print_keypeg_or_space(key_peg_array[2])
    print_keypeg_or_space(key_peg_array[3])
  end

  def print_line(current_line)
    if current_line == :top_line
      print "-----------------"
      print "  -----------------------------------------------  "
      print "-----------------\n"
      print "|"
    else
      print "|"
      print "\n-----------------"
      print "  -----------------------------------------------  "
      print "-----------------\n"
    end
  end

  def print_keypeg_or_space(keypeg_spot)
    if keypeg_spot.nil?
      print " " * 8
    else
      print "#{keypeg_spot.center(8, " ")}"
    end
  end

  def print_code(code)
    code.each_with_index do |code_peg, spot|
      if spot == 0
          print "#{code_peg.capitalize.center(11, " ")}"
      else
          print "|#{code_peg.capitalize.center(11, " ")}"
      end
    end
  end
end

# board = Board.new(%i[blue red green green])

# print board.board[:shield]
