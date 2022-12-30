require './lib/cell'
require './lib/board'

describe Cell do 

  describe "#horizontal conditions" do

    it "checks horizontal neighbors" do 
      game = Board.new(8,8)
      game.board[5][2] = "O"
      game.board[6][2] = "X"
      game.board[6][3] = "X"
      recent_move = Cell.new(6,2,game.board)
      recent_move.horizontal_traversal
      expect(recent_move.horizontal_neighbors).to eql(1)
    end

    it "checks horitzonal win (default win condition of 3)" do
      game = Board.new(8,8)
      game.board[5][2] = "O"
      game.board[6][2] = "X"
      game.board[6][3] = "X"
      game.board[6][4] = "X"
      recent_move = Cell.new(6,2,game.board)
      expect(recent_move.won?(3)).to eql(true)
    end

    it "checks horitzonal non-win" do
      game = Board.new(8,8)
      game.board[5][2] = "O"
      game.board[6][2] = "X"
      game.board[6][3] = "X"
      game.board[6][5] = "X"
      recent_move = Cell.new(6,2,game.board)
      expect(recent_move.won?(3)).to eql(false)
    end

    it "checks that a cell in the left column won't count additional neigbors" do 
      game = Board.new(8,8)
      game.board[0][0] = "X"
      game.board[0][1] = "X"
      game.board[0][7] = "X"
      recent_move = Cell.new(0,0,game.board)
      recent_move.horizontal_traversal
      expect(recent_move.horizontal_neighbors).to eql(1)
    end

    it "checks that a cell in the right column won't count additional neigbors" do 
      game = Board.new(8,8)
      game.board[0][7] = "X"
      game.board[0][6] = "X"
      game.board[0][0] = "X"
      recent_move = Cell.new(0,7,game.board)
      recent_move.horizontal_traversal
      expect(recent_move.horizontal_neighbors).to eql(1)
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
      expect(recent_move.won?(3)).to eql(true)
    end

    it "checks vertical non-win" do 
      game = Board.new(8,8)
      game.board[5][2] = "X"
      game.board[6][2] = "X"
      game.board[6][3] = "X"
      game.board[6][5] = "X"
      recent_move = Cell.new(6,2,game.board)
      expect(recent_move.won?(3)).to eql(false)
    end

    it "checks that a cell in the top column won't count additional neigbors" do 
      game = Board.new(8,8)
      game.board[0][0] = "X"
      game.board[1][0] = "X"
      game.board[1][7] = "X"
      recent_move = Cell.new(0,0,game.board)
      recent_move.vertical_traversal
      expect(recent_move.vertical_neighbors).to eql(1)
    end

    it "checks that a cell in the bottom column won't count additional neigbors" do 
      game = Board.new(8,8)
      game.board[7][0] = "X"
      game.board[6][0] = "X"
      game.board[0][0] = "X"
      recent_move = Cell.new(7,0,game.board)
      recent_move.vertical_traversal
      expect(recent_move.vertical_neighbors).to eql(1)
    end
   
  end

  describe "#diagonal up_left conditions" do

    it "checks diagonal left neighbors" do
      game = Board.new(8,8)
      game.board[4][2] = "X"
      game.board[5][3] = "X"
      game.board[6][3] = "X"
      game.board[6][5] = "X"
      recent_move = Cell.new(4,2,game.board)
      recent_move.diagonal_left_traversal
      expect(recent_move.left_diagonal_neighbors).to eql(1)
    end

    it "checks diagonal left win condition" do
      game = Board.new(8,8)
      game.board[4][2] = "X"
      game.board[5][3] = "X"
      game.board[6][4] = "X"
      game.board[6][5] = "X"
      recent_move = Cell.new(6,4,game.board)
      expect(recent_move.won?(3)).to eql(true)
    end

    it "checks diagonal left non-win" do
      game = Board.new(8,8)
      game.board[4][2] = "X"
      game.board[5][3] = "X"
      game.board[6][7] = "X"
      game.board[6][5] = "X"
      recent_move = Cell.new(4,2,game.board)
      expect(recent_move.won?(3)).to eql(false)
    end

    it "checks that a cell in the top/left column won't count additional neigbors" do 
      game = Board.new(8,8)
      game.board[0][0] = "X"
      game.board[1][1] = "X"
      game.board[1][7] = "X"
      recent_move = Cell.new(0,0,game.board)
      recent_move.diagonal_left_traversal
      expect(recent_move.left_diagonal_neighbors).to eql(1)
    end

    it "checks that a cell in the bottom/right column won't count additional neigbors" do 
      game = Board.new(8,8)
      game.board[7][7] = "X"
      game.board[6][6] = "X"
      game.board[5][0] = "X"
      recent_move = Cell.new(7,7,game.board)
      recent_move.diagonal_left_traversal
      expect(recent_move.left_diagonal_neighbors).to eql(1)
    end
  end


  describe "#diagonal up_right conditions" do 

    it "checks diagonal right neighbors" do 
      game = Board.new(8,8)
      game.board[6][2] = "X"
      game.board[5][3] = "X"
      game.board[4][0] = "X"
      game.board[6][5] = "X"
      recent_move = Cell.new(6,2,game.board)
      recent_move.diagonal_right_traversal
      expect(recent_move.right_diagonal_neighbors).to eql(1)
    end

    it "checks diagonal left win condition" do
      game = Board.new(8,8)
      game.board[6][2] = "X"
      game.board[5][3] = "X"
      game.board[4][4] = "X"
      game.board[6][5] = "X"
      recent_move = Cell.new(4,4,game.board)
      expect(recent_move.won?(3)).to eql(true)
    end

    it "checks diagonal left non-win" do
      game = Board.new(8,8)
      game.board[6][2] = "X"
      game.board[5][3] = "X"
      game.board[4][1] = "X"
      game.board[6][5] = "X"
      recent_move = Cell.new(6,2,game.board)
      expect(recent_move.won?(3)).to eql(false)
    end


    it "checks that a cell in the top/right column won't count additional neigbors" do 
      game = Board.new(8,8)
      game.board[0][7] = "X"
      game.board[1][6] = "X"
      game.board[3][7] = "X"
      recent_move = Cell.new(0,0,game.board)
      recent_move.diagonal_right_traversal
      expect(recent_move.right_diagonal_neighbors).to eql(1)
    end

    it "checks that a cell in the bottom/left column won't count additional neigbors" do 
      game = Board.new(8,8)
      game.board[0][7] = "X"
      game.board[1][6] = "X"
      game.board[5][5] = "X"
      recent_move = Cell.new(0,7,game.board)
      recent_move.diagonal_right_traversal
      expect(recent_move.right_diagonal_neighbors).to eql(1)
    end

  end
  
end
    