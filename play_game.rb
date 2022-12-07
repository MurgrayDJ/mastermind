require './player'
require './board'

class PlayGame
  def initialize
    puts "---------- Welcome to Mastermind! ----------"
    print_rules
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

  def print_rules
    puts "Please visit the Mastermind Wikipedia page for general rules on how to play."
    puts "For this specific game, here is what you need to know about how to play:"
    puts " - Codes can contain multiple of the same color peg."
    puts " - No blank pegs."
    puts " - Black pegs for correct code pegs in the right position."
    puts " - White pegs for correct code pegs in the wrong position."
    puts " - You must put all the right code pegs in the right positions to win. "
    puts "And here is some general stuff to keep in mind: "
    puts " - Code peg colors must be spelled correctly to be entered."
    puts " - Type \"exit\" at any time to exit the game."
    puts " - Type \"help\" at any time to print this message again."
    puts "Please review the rules above, and type \"Ready!\" when you're ready to play."
    get_valid_data("Ready?: ", nil, ["ready!"])
  end

  def play_game
    until @board.guesses == 12 do
      row_symbol = "row#{@board.guesses}".to_sym
      play_round(row_symbol)
      get_key_pegs(row_symbol)
      puts "Here's the updated board: "
      @board.print_board
      if @board.board[row_symbol]["key_pegs"].length == 4
        if win?(row_symbol)
          end_game
          exit
        end
      end
      @board.guesses += 1
    end
    end_game
  end
  
  def play_round(row_symbol)
    puts "Codebreaker, please make guess #{@board.guesses}: "
    @board.board[row_symbol] = {
      "guess" => code_entry,
      "key_pegs" => []
    }
  end

  def get_key_pegs(row_symbol)
    current_guess = @board.board[row_symbol]["guess"]
    shield_code = @board.board[:shield]
    shield_check = [false, false, false, false]
    guess_check = [false, false, false, false]
    current_guess.each_with_index do |code_peg, spot_num|
      if code_peg == shield_code[spot_num]
        @board.board[row_symbol]["key_pegs"] << "Black"
        shield_check[spot_num] = true
        guess_check[spot_num] = true
      end
      shield_code.each_with_index do |shield_code_peg, index|
        if code_peg == shield_code_peg && shield_check[index] == false && guess_check[spot_num] == false
          @board.board[row_symbol]["key_pegs"] << "White"
          shield_check[index] = true
          guess_check[spot_num] = true
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

  def win?(row_symbol)
    key_pegs = @board.board[row_symbol]["key_pegs"]
    key_pegs.all? {|key_peg| key_peg == "Black"}
  end

  def end_game
    if @board.guesses == 12
      puts "Game over! All the rows have been filled and the code is not broken!"
      puts "Great code #{@code_maker.name}!"
    else
      puts "Game over! The codebreaker has broken the code!"
      puts "Great work #{@code_breaker.name}!"
    end
  end
end

PlayGame.new
