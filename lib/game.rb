require './lib/board'
require './lib/player'
require './lib/cell'


def turn_order
  puts" The turn order shall be " + Player.player_list.map {|player| player.name}.join(", ") + ". \n"
end

def turn
  puts @game_board.display
  
  turn_order = 0

  while turn_order <= Player.player_list.length && won? == false
    puts "It's #{Player.player_list[turn_order].name}'s turn"
    puts "Which cell would you like to put your symbol?"
   #Build out symbol placing logic