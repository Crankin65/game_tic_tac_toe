require './lib/cell'
require './lib/board'

describe Cell do 

  describe "#horizontal conditions" do

    it "checks horizontal neighbors" do 
      board = [
        [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #0,0
        [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #1,0
        [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #2,0
        [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #3,0
        [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #4,0
        [[ ],[ ],["O"],[ ],[ ],[ ],[ ],[ ]], #5,0
        [[ ],[ ],["X"],["X"],[ ],[ ],[ ],[ ]], #6,0
        [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #7,0
      ]

      recent_move = Cell.new(6,2,board)
      recent_move.horizontal_traversal
      expect(recent_move.horizontal_neighbors).to eql(1)
    end

    it "checks horitzonal win (default win condition of 3)" do
      # board = [
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #0,0
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #1,0
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #2,0
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #3,0
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #4,0
      #   [[ ],[ ],["O"],[ ],[ ],[ ],[ ],[ ]], #5,0
      #   [[ ],[ ],["X"],["X"],["X"],[ ],[ ],[ ]], #6,0
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #7,0
      # ]
      
      game = Board.new(8,8)
      game.board[5][2] = "O"
      game.board[6][2] = "X"
      game.board[6][3] = "X"
      game.board[6][4] = "X"
      # win_condition = double("win_condition", :win => 3)

      recent_move = Cell.new(6,2,game.board)
      expect(recent_move.won?).to eql(true)
    end

    it "checks horitzonal non-win" do
      # board = [
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #0,0
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #1,0
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #2,0
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #3,0
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #4,0
      #   [[ ],[ ],["O"],[ ],[ ],[ ],[ ],[ ]], #5,0
      #   [[ ],[ ],["X"],["X"],["X"],[ ],[ ],[ ]], #6,0
      #   [[ ],[ ],[ ],[ ],[ ],[ ],[ ],[ ]], #7,0
      # ]
      
      game = Board.new(8,8)
      game.board[5][2] = "O"
      game.board[6][2] = "X"
      game.board[6][3] = "X"
      game.board[6][5] = "X"
      # win_condition = double("win_condition", :win => 3)

      recent_move = Cell.new(6,2,game.board)
      expect(recent_move.won?).to eql(false)
    end

  end

  describe "vertical conditions" do

    it "checks vertical neighbors" do
      game = Board.new(8,8)
      game.board[5][2] = "X"
      game.board[6][2] = "X"
      game.board[6][3] = "X"
      game.board[6][5] = "X"
      recent_move = Cell.new(5,2,game.board)
      recent_move.vertical_traversal
      expect(recent_move.vertical_neighbors).to eql (1)
    end

    it "checks vertical win condition (default win condition 3)" do
      
      game = Board.new(8,8)
      game.board[5][2] = "X"
      game.board[6][2] = "X"
      game.board[7][2] = "X"
      game.board[6][5] = "X"

      recent_move = Cell.new(6,2, game.board)
      recent_move.vertical_traversal
      expect(recent_move.won?).to eql(true)
    end

    it "checks vertical non-win" do 

      game = Board.new(8,8)
      game.board[5][2] = "X"
      game.board[6][2] = "X"
      game.board[6][3] = "X"
      game.board[6][5] = "X"

      recent_move = Cell.new(6,2,game.board)
      expect(recent_move.won?).to eql(false)
    end
  end




end


# Use doubles to fake method