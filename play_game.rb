require './player'
require './board'

class PlayGame
  def initialize
    welcome_player
    decide_play_style
    @code_maker 
    @code_breaker 
    @board = create_board
    play_game
  end

  def decide_play_style
    print "\n\nEnter player name: "
    player_name = gets.chomp
    puts "#{player_name.capitalize}, do you want to be the code maker or code breaker?"
    prompt = "Enter 1 for code maker, enter 2 for code breaker: "
    player_num = get_valid_data(prompt, nil, ["1", "2"])
    create_players(player_name, player_num)
  end

  def create_players(player_name, player_num)
    if player_num == "1"
      @code_maker = Player.new(player_name, :human)
      @code_breaker = Player.new("Computer", :computer)
    else
      @code_maker = Player.new("Computer", :computer)
      @code_breaker = Player.new(player_name, :human)
    end
  end

  def create_board
    board = Board.new(get_shield_code)
  end

  def get_shield_code
    shield_code = []

    if @code_maker.type == :computer
      shield_code = @code_maker.generate_shield
      puts "\n\n-------- Generating code... ---------"
      sleep 2
      puts "The computer has generated the code!\n\n"
    else
      puts "Codemaker, please enter your 4-part shield code:"
      shield_code = code_entry
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

  def welcome_player
    puts "---------- Welcome to Mastermind! ----------"
    print_rules
    puts "Please review the rules above, and type \"Ready!\" when you're ready to play."
    get_valid_data("Ready?: ", nil, ["ready!"])
  end

  def print_rules
    puts "Please visit the Mastermind Wikipedia page for general rules on how to play."
    puts "For this specific game, here is what you need to know about how to play:"
    puts " - Codes can contain multiple of the same color peg."
    puts " - No blank pegs."
    puts " - Black pegs for correct code pegs in the right position."
    puts " - White pegs for correct code pegs in the wrong position."
    puts " - The codebreaker must put the right code pegs in the right positions to win. "
    puts " - The key pegs don't have to match the position of the code peg they're referencing."
    puts "And here is some general stuff to keep in mind: "
    puts " - Code peg colors must be spelled correctly to be entered."
    puts " - Type \"exit\" at any time to exit the game."
    puts " - Type \"help\" at any time to print this message again."
    puts "Finally, here are the possible code colors for the game:"
    Board.print_colors
    print "\n\n"
  end

  def play_game
    until @board.guesses == 13 do
      row_symbol = "row#{@board.guesses}".to_sym
      play_round(row_symbol)
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
    @board.board[row_symbol] = {
      "guess" => [],
      "key_pegs" => []
    }
    if @code_breaker.type == :human
      puts "Codebreaker, please make guess number #{@board.guesses}: "
      Board.print_colors
      @board.board[row_symbol]["guess"] = code_entry
      get_key_pegs(row_symbol)
    else
      puts "The computer will now try to make it's guess..."
      sleep 2
      @board.board[row_symbol]["guess"] = generate_guess(row_symbol)
      @board.print_row(row_symbol)
      puts "Reminder of your hidden code: "
      @board.print_shield
      input_feedback(row_symbol)
    end
  end

  def generate_guess(row_symbol)
    guess = []
    white_pegs = []
    prev_row_symbol = "row#{@board.guesses-1}".to_sym
    if row_symbol == :row1 || @board.board[prev_row_symbol]["key_pegs"].empty?
      4.times do 
        guess << Board.board_colors.sample
      end
    else
      check_keypeg_color(prev_row_symbol, guess, white_pegs)
      guess = replace_wrong_pegs(guess, white_pegs)
    end
    guess
  end

  def check_keypeg_color(prev_row_symbol, guess, white_pegs)
    @board.board[prev_row_symbol]["key_pegs"].each_with_index do |key_peg, peg_index|
      peg_of_interest = @board.board[prev_row_symbol]["guess"][peg_index]
      if key_peg == "Black"
        guess << peg_of_interest
      elsif key_peg == "White"
        white_pegs << peg_of_interest
        guess << nil
      else
        guess << nil
      end
    end
  end

  def replace_wrong_pegs(guess, white_pegs)
    num_spots_left = guess.count(nil)
    if num_spots_left >= 1
      while white_pegs.length < num_spots_left
        white_pegs << Board.board_colors.sample
      end
      code_pegs = white_pegs.shuffle
      guess.each_with_index do |key_peg, peg_index|
        if key_peg == nil
          guess[peg_index] = code_pegs.pop
        end
      end
    end
    guess
  end

  def input_feedback(row_symbol)
    puts "Code maker, please put enter your feedback on the computer's guess."
    puts "White for correct color, wrong position. Black for correct color, right position."
    puts "No key peg means the color is not in the code. Just press enter to represent no peg."
    4.times do |key_peg_num|
      key_peg = get_valid_data("  Key peg #{key_peg_num}: ", nil, ["White", "Black", ""])
      @board.board[row_symbol]["key_pegs"] << key_peg.capitalize
    end
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
        elsif response.downcase == "help"
          print_rules
          break
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
    if @board.guesses == 13
      puts "Game over! All the rows have been filled and the code is not broken!"
      puts "Great work #{@code_maker.name}!"
      puts "Here was their code: "
      @board.print_shield
    else
      puts "Game over! The codebreaker has broken the code!"
      puts "Great work #{@code_breaker.name}!"
    end
  end
end

PlayGame.new
