class Player
  attr_accessor :name, :symbol, :player_number
  @@player_list = []

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @@player_list << name
    #@player_number = @@player_list.each
    # player number = index in the player list
  end

  def 

end