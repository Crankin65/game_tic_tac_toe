require './lib/board'
require './lib/player'
require './lib/game'
require './lib/cell'


def game_play
  tic_tac_toe = Game.new("tic_tac_toe")
  rows = tic_tac_toe.requested_rows
  columns = tic_tac_toe.requested_columns 
  new_board = Board.new(rows, columns)

  tic_tac_toe.add_players
  tic_tac_toe.validate_players
  tic_tac_toe.winning_condition(new_board)
  tic_tac_toe.define_turn_order

  tic_tac_toe.turn(new_board)
end

game_play
