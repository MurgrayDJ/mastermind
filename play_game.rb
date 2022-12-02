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
      get_key_pegs(@board.guesses)
      @board.guesses += 1
      puts "Here's the updated board: "
      @board.print_board
    end
  end
  
  def play_round(round_num)
    puts "Codebreaker, make your guess: "
    @board.board["row#{round_num}".to_sym] = {
      "guess" => code_entry,
      "key_pegs" => []
    }
  end

  def get_key_pegs(round_num)
    row_symbol = "row#{round_num}".to_sym
    current_guess = @board.board[row_symbol]["guess"]
    shield_code = @board.board[:shield]
    shield_check = [false, false, false, false]
    guess_check = [false, false, false, false]
    current_guess.each_with_index do |code_peg, spot_num|
      if code_peg == shield_code[spot_num]
        @board.board[row_symbol]["key_pegs"] << "Black"
        shield_check[spot_num] = true
        guess_check[spot_num] = true
      else
        shield_code.each_with_index do |shield_code_peg, index|
          if code_peg == shield_code_peg && shield_check[index] == false && guess_check[spot_num] == false
            @board.board[row_symbol]["key_pegs"] << "White"
            shield_check[index] = true
            guess_check[spot_num] = true
          end
        end 
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
