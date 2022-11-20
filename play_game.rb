require './player.rb'

class PlayGame
  def initialize
    @code_maker = createPlayer(1)
    @code_breaker = createPlayer(2);

    puts @code_breaker.name
    puts @code_maker.name
  end

  def createPlayer(player_num)
    if player_num == 1
      player_name = "the computer"
      player_type = :code_maker
    else
      print "Enter player name: "
      player_name = gets.chomp
      player_type = :code_breaker
    end
    new_player = Player.new(player_name, player_type)
  end
end

new_game = PlayGame.new()