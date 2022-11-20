class Player
  attr_accessor :name, :type

  def initialize(name, type)
    @name = name
    @type = type
  end
end

player1 = Player.new('Murgray', :codemaker)

puts player1.type
