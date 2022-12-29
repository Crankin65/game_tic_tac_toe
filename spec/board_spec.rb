require './lib/board'
require 'stringio'

describe Board do

  describe "#display" do

    it "returns the correct number of colums & rows"do 
      game = Board.new(8,8)
      game.game_array
      expected_display = <<~TEXT 
      H| | | | | | | | |
      G| | | | | | | | |
      F| | | | | | | | |
      E| | | | | | | | |
      D| | | | | | | | |
      C| | | | | | | | |
      B| | | | | | | | |
      A| | | | | | | | |
        1 2 3 4 5 6 7 8 
      TEXT
      expect(game.display).to eql(expected_display)
    end
  end

  describe "#board_size" do 
    it "checks the number of rows" do
      game = Board.new(8,8)
      expect(game.board.length).to eql(8)
    end

    it "checks random board position is nil" do
      game = Board.new(8,8)
      expect(game.board[rand(1..6)][rand(1..6)]).to eql(nil)
    end

    it "checks number of columns in each row" do
      game = Board.new(8,8)
      expect(game.board[0].size).to eql(8)
    end

  end


  describe "#update" do
    it "updates cell A4 to 'X' " do
      game = Board.new(8,8)
      game.update_method(7, 4, "X")
      expect(game.board[7][4]).to eql("X")
    end
  
    it "udpates cell f7 to 'O' " do
      game = Board.new(8,8)
      game.update_method(2, 7, "O")
      expect(game.board[2][7]).to eql("O")
    end
    

  end

  describe "#cell_selection" do 
    it "updates cell B7 based on cell selection from user" do
      game = Board.new(8,8)
      game.cell_selection("X")
      expect(game.board[6][6]).to eql("X")
    end
  end
      
end