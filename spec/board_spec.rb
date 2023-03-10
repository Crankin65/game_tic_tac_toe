require './lib/board'
require 'stringio'

describe Board do

  describe "#display" do

    it "returns the correct number of colums & rows 8x8 "do 
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

    it "returns the correct number of colums & rows with spacing 12 x 12"do 
      game = Board.new(12,12)
      game.game_array
      expected_display = <<~TEXT 
      L| | | | | | | | | |  |  |  |
      K| | | | | | | | | |  |  |  |
      J| | | | | | | | | |  |  |  |
      I| | | | | | | | | |  |  |  |
      H| | | | | | | | | |  |  |  |
      G| | | | | | | | | |  |  |  |
      F| | | | | | | | | |  |  |  |
      E| | | | | | | | | |  |  |  |
      D| | | | | | | | | |  |  |  |
      C| | | | | | | | | |  |  |  |
      B| | | | | | | | | |  |  |  |
      A| | | | | | | | | |  |  |  |
        1 2 3 4 5 6 7 8 9 10 11 12 
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
      game.update(7, 4, "X")
      expect(game.board[7][4]).to eql("X")
    end
  
    it "udpates cell f7 to 'O' " do
      game = Board.new(8,8)
      game.update(2, 7, "O")
      expect(game.board[2][7]).to eql("O")
    end

    describe "when out of bounds" do 
      #Update out of bounds tests to mimic tests on line 67
      #Condition should be how board reacts 
  
    end

    it "doesn't update cell L9 to 'L' (Row) " do
      game= Board.new(8,8)
      expect(game.row_selection("L")).to eql(false)
    end

    it "doesn't update cell L9 to 'L' (Row) " do
      game= Board.new(8,8)
      expect(game.column_selection(9)).to eql(false)
    end
    
  end

  describe "#cell_selection" do 
    it "updates cell B7 based on cell selection from user" do
      game = Board.new(8,8)
      row = game.row_selection("B")
      column = game.column_selection(7)
      game.update(row, column,"X")
      expect(game.board[6][6]).to eql("X")
    end
  end
      
end