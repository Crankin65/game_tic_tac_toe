class Player
  attr_accessor :name, :symbol, :player_number
  @@player_list = []

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @player_number = 1
    @@player_list << self
    @player_number = @@player_list.find_index do |player| 
      player.name == @name
    end + 1
  end

  def self.remove_one_player(delete_name)
    index_to_delete = @@player_list.find_index do |player|
      player.name == delete_name
    end

    @@player_list.delete_at(index_to_delete)
  end

  def self.reset_players
    @@player_list = []
  end

  def self.player_list
    @@player_list
  end

  def self.player_names_and_symbols
    self.player_list.each do |player|
      puts "#{player.name} is playing and is using '#{player.symbol}' as their symbol."
    end
  end
  
  def self.player_names
    name_array = []
    self.player_list.map do |player|
      name_array << player.name
    end
    name_array
  end


end

# player_one = Player.new("bob", "X")
# player_two = Player.new("mary", "O")
# # player_three = Player.new("Suzy", "P")
# # Player.remove_one_player("mary")
# # Player.reset_players
# # Player.player_names
# p Player.player_names
