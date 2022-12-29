require './lib/board'
require './lib/player'
require './lib/cell'

class Game
  attr_accessor :name

  def initialize(name)
    @name = name
    @turn_order = 0
  end

  def create_player
    puts "What's your name?"
    player_name = $stdin.gets.chomp

    puts "What symbol will you play with? (We recommend a single symbol)"
    player_symbol = $stdin.gets.chomp

    until player_symbol.length == 1
      puts "What symbol will you play with? (We recommend a single symbol)"
      player_symbol = $stdin.gets.chomp
    end

      Player.new(player_name, player_symbol)

  end

  def add_players
    puts "How many players will be playing?"
    total_players = gets.chomp.to_i

    until total_players != 0
      puts "Please enter a number larger than 0"
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
      puts "There are not any players"
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
        validate_players
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

  def turn(board)

    board.puts_display
  
    while @turn_order <= Player.player_list.length && board.game_condition == "active"

      puts "It's #{Player.player_list[@turn_order].name}'s turn"
    
      board.cell_selection(Player.player_list[@turn_order].symbol)
      recent_symbol = Player.player_list[@turn_order].symbol

      @turn_order += 1
      board.puts_display
      puts "The game is currenly #{board.game_condition}"
      board.tie_check

      if @turn_order == Player.player_list.length
        @turn_order = 0
      end
      
    end

    if board.game_condition == "done"
      puts "#{Player.player_list.find {|player| recent_symbol == player.symbol}.name} has won the game!"
    elsif board.game_condition == "tie"
      puts "The game has ended in a tie"
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

  def winning_condition(board)
    puts "How many in a row will win the game? The minimum is 3. The maximum is the number of rows or columns you have (the highest of the two)"

    winning_condition = gets.chomp.to_i
    puts "The number of rows is #{board.number_of_rows} and the number of columns is #{board.number_of_columns}"

    until (winning_condition <= board.number_of_rows || winning_condition <= board.number_of_columns) #&& winning_condition >= 3

      puts "Please put a number that is greater than 3, and less than or equal to the highest number (between rows or columns)"
      
      puts "Nope, you're hitting this one"
      winning_condition = gets.chomp.to_i
    end

    board.number_to_win = winning_condition
    puts "you're hitting this condition"
  end

end




# create_board(requested_rows,requested_columns)
# winning_condition
# game_start

