require './board'

class Player
  attr_accessor :name, :type

  def initialize(name, type)
    @name = name
    @type = type
  end

  def generate_shield
    shield_code = []
    color_options = Board.board_colors
    4.times do 
      shield_code << color_options.sample
    end
    shield_code
  end
end

# player1 = Player.new('Murgray', :codemaker)

# puts player1.type
