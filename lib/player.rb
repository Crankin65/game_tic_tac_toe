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

  def create_player
    puts "What's your name?"
    player_name = $stdin.gets.chomp
  
    puts "What symbol will you play with? (We recommend a single symbol)"
    player_symbol = $stdin.gets.chomp
  
    until @player_symbol.length == 1
      puts "What symbol will you play with? (We recommend a single symbol)"
      player_symbol = $stdin.gets.chomp
    end
  
  
    puts "Is that information correct? Your name is #{player_name} and you'll be using #{player_symbol}? Y/N"
    reponse = $stdin.gets.chomp
  
    until (response.downcase == "yes") || (response.downcase == "y") 
      create_player
    end
  
    Player.new(player_name, player_symbol)
  end

  def add_players
    puts "How many players will be playing?"
    total_players = gets.chomp.to_i
  
    until total_players != 0
      puts "That's not a number"
      total_players = gets.chomp.to_i
    end
  
    while Player.player_list.length <= total_players
      create_player
    end
  end

  def validate_players
    Player.player_names_and_symbols
    puts "Are those the correct players and symbols? Yes/No/Add/Subtract"
  
    response = gets.chomp.downcase
  
    if response == "no"
      Player.reset_players
      add_players
  
    elsif Player.player_list == [] && response == "yes"
      puts "There aren't any players"
      add_players
  
    elsif response == "yes"
      puts "Thank You"
      
    elsif response == "subtract"
      
      puts "The current player list is " + @@player_list.map {|player| player.name}.join(", ") + "."
  
      puts "Which player should be deleted? (Enter 'back' or 'exit' if you'd go go back)"
  
      delete_response = $stdin.gets.chomp.downcase
      
      if @@player_list.any? {|player| delete_response == player.name}
        Player.remove_one_player(delete_response)

      elsif (delete_response == "back") || (delete_response == "exit")
        validate_players
      else
         puts "That's not a player in this game"
      end
  
    elsif response == "add"
      create_player
      validate_players
  
    else
      puts "That's not a yes, no, add, or subtract"
      validate_players
    end
  
  end

end

# player_one = Player.new("bob", "X")
# player_two = Player.new("mary", "O")
# # player_three = Player.new("Suzy", "P")
# # Player.remove_one_player("mary")
# # Player.reset_players
# # Player.player_names
# p Player.player_names
