require './player'
require './board'

class PlayGame
  def initialize
    @code_maker = create_player(1)
    @code_breaker = create_player(2)
    @board = create_board
  end

  def create_player(player_num)
    if player_num == 1
      player_name = 'Computer'
      player_type = :code_maker
    else
      print 'Enter player name: '
      player_name = gets.chomp
      player_type = :code_breaker
    end
    Player.new(player_name, player_type)
  end

  def get_shield_code
    puts "Codemaker, please enter your shield code."
    puts "You can enter one of the following values:"
    Board.print_colors
    print "Row 1:"
    shield_code = gets.chomp
  end

  def create_board
    board = Board.new(get_shield_code)
  end
end

PlayGame.new
