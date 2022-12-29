require './lib/board'
require './lib/player'
require './lib/cell'

def create_player
  puts "What's your name?"
  player_name = $stdin.gets.chomp

  puts "What symbol will you play with? (We recommend a single symbol)"
  player_symbol = $stdin.gets.chomp

  until player_symbol.length == 1
    puts "What symbol will you play with? (We recommend a single symbol)"
    player_symbol = $stdin.gets.chomp
  end


  puts "Is that information correct? Your name is #{player_name} and you'll be using '#{player_symbol}' ? Y/N"
  response = $stdin.gets.chomp

  if (response.downcase == "n") || (response.downcase == "no") 
    create_player
  else
    Player.new(player_name, player_symbol)
  end

end


def add_players
  puts "How many players will be playing?"
  total_players = gets.chomp.to_i

  until total_players != 0
    puts "That's not a number"
    total_players = gets.chomp.to_i
  end

  until Player.player_list.length == total_players
    create_player
  end
end

def validate_players
  Player.player_names_and_symbols
  puts "Are those the correct players and symbols? Yes/No/Add/Subtract '\n'"

  response = gets.chomp.downcase

  if response.downcase == "no"
    Player.reset_players
    add_players

  elsif Player.player_list == [] && response.downcase == "yes"
    puts "There aren't any players"
    add_players

  elsif response.downcase == "yes"
    puts "Thank You"
    
  elsif response.downcase == "subtract"
    
    puts "The current player list is " + Player.player_list.map {|player| player.name}.join(", ") + "."

    puts "Which player should be deleted? (Enter 'back' or 'exit' if you'd go go back)"

    delete_response = $stdin.gets.chomp.downcase
    
    if @@player_list.any? {|player| delete_response == player.name}
      Player.remove_one_player(delete_response)

    elsif (delete_response.downcase == "back") || (delete_response.downcase == "exit")
      validate_players
    else
       puts "That's not a player in this game"
    end

  elsif response.downcase == "add"
    create_player
    validate_players

  else
    puts "That's not a yes, no, add, or subtract"
    validate_players
  end

end

def define_turn_order
  Player.player_list.shuffle!
  puts" The turn order shall be " + Player.player_list.map {|player| player.name}.join(", ") + ". \n"
end

def game_start
  add_players
  validate_players
  define_turn_order
 
  @turn_order = 0
  turn
end

def turn 

  puts @game_board.display

  while @turn_order <= Player.player_list.length && (@game.game_condition != "done" ||@game.game_condition != "tie")
    puts "It's #{Player.player_list[@turn_order].name}'s turn"
   
    @game.cell_selection(Player.player_list[@turn_order].symbol)

    @turn_order += 1
    @game.puts_display
    @game.tie_check

    if @turn_order == Player.player_list.length
      @turn_order = 0
    end


  end

  if @game.game_condition == "done"
    puts "the game is won"
  elsif @game.condition == "tie"
    puts "the game is tied"
  end
  
  
  
end
   
def requested_rows
  puts "How many rows would you like? (There's a minimum of three and maximum of 26)"

  rows = gets.chomp.to_i

  until (rows >= 3 && rows <= 26) && rows.integer?
    puts "Please enter a number that's greater than or equal to 3 and less than or equal to 26"
    rows = gets.chomp.to_i
  end

  rows
end

def requested_columns
  puts "How many columns would you like? (There's a minimum of three and maximum of 99)"

  columns = gets.chomp.to_i

  until (columns >= 3 && columns <= 99) && columns.integer?
    puts "Please enter a nubmer greater than or equal to 3 and less than or equal to 99"
    columns = gets.chomp.to_i
  end

  columns
end


def create_board(rows,columns)
  @game = Board.new(rows ,columns)
  @game.puts_display
end

create_board(requested_rows,requested_columns)
game_start

