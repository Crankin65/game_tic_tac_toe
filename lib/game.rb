require './lib/board'
require './lib/player'
require './lib/cell'

def requested_rows
  puts "How many rows would you like? (There's a minimum of three)"

  @rows = gets.chomp.to_i

  until @rows >= 3 && @rows.integer?
    puts "Please enter a number that's greater than or equal to 3"
    @rows = gets.chomp.to_i
  end
end

def requested_columns
  puts "How many columns would you like? (There's a minimum of three)"

  @columns = gets.chomp.to_i

  until @columns >= 4 && @columns.integer?
    puts "Please enter a nubmer greater than or equal to 3"
    @columns = gets.chomp.to_i
  end
end

def create_board
  requested_rows
  requested_columns
  @game_board = Board.new(@rows,@columns)
  @gameboard.puts_display
end

def create_player
  puts "What's your name?"
  @player_name = $stdin.gets.chomp

  puts "What symbol will you play with?"
  @player_symbol = $stdin.gets.chomp

  puts "Is that information correct? Your name is #{@player_name} and you'll be using #{@player_symbol}? Y/N"
  reponse = $stdin.gets.chomp

  until (response.downcase == "yes") || (response.downcase == "y") 
    create_player
  end

  Player.new(@player_name, @player_symbol)
end

def add_players
  puts "How many players will be playing?"
  total_players = gets.chomp.to_i

  until total_players != 0
    puts "That's not a number"
    total_players = gets.chomp.to_i
  end

  current_number_of_players = 0

  while current_number_of_players <= total_players
    create_player
    current_number_of_players += 1
  end
end

def validate_players
  Player.player_names_and_symbols
  puts "Are those the correct players and symbols? Yes/No/Add/Subtract"

  response - gets.chomp.downcase

  if response == "no"
    Player.reset_players
    add_players

  elsif Player.player_list == [] && response == "yes"
    puts "There aren't any players"
    add_players

  elsif response == "yes"
    puts "Thank You"
    Player.player_list.shuffle!
    
  elsif response == "subtract"
    puts "The current player list is" 
    p Player.player_names
    puts "Which player should be deleted?"

    

end