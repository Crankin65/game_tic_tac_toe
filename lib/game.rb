require './lib/board'
require './lib/player'
require './lib/cell'


def define_turn_order
  Player.player_list.shuffle!
  puts" The turn order shall be " + Player.player_list.map {|player| player.name}.join(", ") + ". \n"
end

def game_start
  @turn_order = 0
end

def turn 

  puts @game_board.display

  while turn_order <= Player.player_list.length && (won? == false || @game_condition = "tie")
    puts "It's #{Player.player_list[turn_order].name}'s turn"
    puts "Which cell would you like to put your symbol?"
    response = $stdin.gets.chomp.split(' ')

    until ((response[0].ord >= 65 && response[0].ord <= 90) ||
      (response[0].ord >= 97 && response[0].ord <= 120)) && (response[1].to_i <= @game_board.number_of_columns)
    
        update(response[0], response[1])
    else
      puts "It's #{Player.player_list[turn].name}'s turn, please enter a cell"
      turn
    end

    @turn_order += 1

    if @turn_order == Player.player_list.length
      @turn_order = 0
    end
  end

  
end
   #Build out symbol placing logic