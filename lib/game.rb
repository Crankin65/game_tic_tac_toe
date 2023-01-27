require './lib/board'
require './lib/player'
require './lib/cell'
require './lib/playerlist'

class Game
  attr_accessor :name

  def initialize(name)
    @name = name
    @turn_order = 0
    @recent_cell = nil
    @player_list = Playerlist.new
  end

  def create_player
    player_name = InputPrompt.ask("What's your name?")
    player_symbol = InputPrompt.ask('What symbol will you play with? (We recommend a single symbol)')

    until player_symbol.length == 1
      player_symbol = InputPrompt.ask('What symbol will you play with? (We recommend a single symbol)')
    end
    @player_list.add_player(Player.new(player_name, player_symbol))
  end

  def add_players
    total_players = InputPrompt.ask("How many players will be playing?").to_i

    until total_players != 1
      total_players = InputPrompt.ask("Please enter a number larger than 1").to_i
    end

    create_player until Player.player_list.length == total_players
  end

  def validate_players
    Player.player_names_and_symbols
    response = InputPrompt.ask("Are those the correct players and symbols? Yes/No/Add/Subtract")

    if response.downcase == 'no'
      Player.reset_players
      add_players
      validate_players

    elsif Player.player_list == [] && response.downcase == 'yes'
      puts 'There are currently no players'
      add_players
      validate_players

    elsif response.downcase == 'yes'
      puts 'Thank You'

    elsif response.downcase == 'subtract'
      puts 'The current player list is ' + Player.player_list.map { |player| player.name }.join(', ') + '.'
      puts "Which player should be deleted? (Enter 'back' or 'exit' if you'd go go back)"
      delete_response = InputPrompt.ask("Which player should be deleted? (Enter 'back' or 'exit' if you'd go go back)")

      if Player.player_list.any? { |player| delete_response == player.name }
        Player.remove_one_player(delete_response)
        validate_players
      elsif (delete_response.downcase == 'back') || (delete_response.downcase == 'exit')
        validate_players
      else
        puts "That's not a player in this game"
        validate_players
      end

    elsif response.downcase == 'add'
      create_player
      validate_players

    else
      puts "That's not a yes, no, add, or subtract"
      validate_players
    end
  end

  def define_turn_order
    Player.player_list.shuffle!
    puts ' The turn order shall be ' + Player.player_list.map { |player| player.name }.join(', ') + ". \n"
  end

  def turn(board)
    board.puts_display

    while @turn_order <= Player.player_list.length && board.game_condition == 'active'

      puts "It's #{Player.player_list[@turn_order].name}'s turn"

      update_game_process(board)

      @recent_symbol = Player.player_list[@turn_order].symbol
      @turn_order += 1
      board.puts_display
      board.tie_check
      win_check(board)

      @turn_order = 0 if @turn_order == Player.player_list.length

    end

    if board.game_condition == 'win'
      puts "#{Player.player_list.find { |player| @recent_symbol == player.symbol }.name} has won the game!"
    elsif board.game_condition == 'tie'
      puts 'The game has ended in a tie'
    end
  end

  def requested_rows
    rows = InputPrompt.ask("How many rows would you like? (There's a minimum of 3 and maximum of 26)").to_i

    until (rows >= 3 && rows <= 26) && rows.integer?
      puts "Please enter a number that's greater than or equal to 3 and less than or equal to 26"
      rows = gets.chomp.to_i
    end

    rows
  end

  def requested_columns
    columns = InputPrompt.ask("How many columns would you like? (There's a minimum of 3 and maximum of 99)").to_i

    until (columns >= 3 && columns <= 99) && columns.integer?
      columns = InputPrompt.ask("Please enter a nubmer greater than or equal to 3 and less than or equal to 99").to_i
    end

    columns
  end

  def winning_condition(board)
    winning_condition = InputPrompt.ask("How many in a row will win the game? The minimum is 3. The maximum is the number of rows or columns you have (the highest of the two)").to_i

    puts "The number of rows is #{board.number_of_rows} and the number of columns is #{board.number_of_columns}"

    until winning_condition <= board.number_of_rows || winning_condition <= board.number_of_columns # && winning_condition >= 3
      winning_condition = InputPrompt.ask("Please put a number that is greater than 3, and less than or equal to the highest number (between rows or columns)").to_i

    end

    board.number_to_win = winning_condition
  end

  def update_game_process(board)
    cell = board.cell_selection

    cell = board.cell_selection until board.row_selection(cell[0]) && board.column_selection(cell[1])

    row = board.row_selection(cell[0])
    column = board.column_selection(cell[1])

    if board.update_check(row, column)
      board.update(row, column, Player.player_list[@turn_order].symbol)
      @recent_cell = Cell.new(row, column, board.board)
    else
      update_game_process(board)
    end
  end

  def win_check(board)
    return unless @recent_cell.won?(board.number_to_win)

    board.game_condition = 'win'
  end
end
