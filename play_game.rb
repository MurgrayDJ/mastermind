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
    puts "Codemaker, please enter your 4-part shield code using the following values:"
    Board.print_colors

    4.times do |spot_num|
      prompt = "Spot #{spot_num + 1}: "
      get_valid_data(prompt, nil, Board.board_colors)
    end

    puts "Shield code entered!"
  end

  def create_board
    board = Board.new(get_shield_code)
  end

  def get_valid_data(prompt, response, valid_responses)
    if response.nil?
      print prompt
      response = gets.chomp
    else
      valid_responses.each do |valid_response|
        if response == valid_response
          return response
        elsif response.downcase == "exit"
          puts "See ya later!"
          exit!
        end
      end
      response = nil
    end
    response = get_valid_data(prompt, response, valid_responses)  
  end
end

PlayGame.new
