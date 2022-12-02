require './player'
require './board'

class PlayGame
  def initialize
    @code_maker = create_player(1)
    @code_breaker = create_player(2)
    @board = create_board
    play_game
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

  def create_board
    board = Board.new(get_shield_code)
  end

  def get_shield_code
    shield_code = []
    puts "Here are the possible code values for the game:"
    Board.print_colors

    if @code_maker.name = 'Computer'
      shield_code = @code_maker.generate_shield
      puts "The computer has entered the code!\n\n"
    else
      puts "Codemaker, please enter your 4-part shield code:"
      shield_code = code_entry
      50.times do
        puts "."
      end
      puts "Shield code entered!"
    end
    shield_code
  end

  def code_entry
    code_array = []
    4.times do |spot_num|
      prompt = "  Spot #{spot_num + 1}: "
      code_array << get_valid_data(prompt, nil, Board.board_colors)
    end
    code_array
  end

  def play_game
    until @board.guesses == 12 do
      play_round(@board.guesses)
      get_feedback(@board.guesses)
      @board.guesses += 1
      puts "Here's the updated board: "
      @board.print_board
    end
  end
  
  def play_round(round_num)
    puts "Codebreaker, make your guess: "
    @board.board["row#{round_num}".to_sym] = {
      "guess" => code_entry,
      "feedback" => [nil, nil, nil, nil]
    }
  end

  def get_feedback(round_num)
    row_symbol = "row#{round_num}".to_sym
    current_guess = @board.board[row_symbol]["guess"]
    shield_code = @board.board[:shield]
    current_guess.each_with_index do |spot_value, spot_num|
      if spot_value == shield_code[spot_num]
        @board.board[row_symbol]["feedback"][spot_num] = "black"
      end
    end
  end

  def get_guess(guess_num)
    print "Codebreaker, make your guess: "
    code_entry
  end

  def get_valid_data(prompt, response, valid_responses)
    if response.nil?
      print prompt
      response = gets.chomp
    else
      valid_responses.each do |valid_response|
        if response.downcase == valid_response.downcase
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
