require './player'

class PlayGame
  def initialize
    @code_maker = createPlayer(1)
    @code_breaker = createPlayer(2)

    puts @code_breaker.name
    puts @code_maker.name
  end

  def create_player(player_num)
    if player_num == 1
      player_name = 'the computer'
      player_type = :code_maker
    else
      print 'Enter player name: '
      player_name = gets.chomp
      player_type = :code_breaker
    end
    Player.new(player_name, player_type)
  end
end

PlayGame.new
