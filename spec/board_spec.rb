require './lib/board'

describe Board do
  before do 
    game = Board.new(8,8)
  end

  describe "#display" do
    it "returns the correct number of colums & rows"do 
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
      expect(game.puts_display).to eql(expected_display)
    end
  end

  describe "#board_size" do 
    it "checks the number of rows" do
      expect(game.@board.length).to eql(8)
    end

    it "checks random board position is nil" do
      expect(game.@board[rand(1..6)][rand(1..6)]).to eql(nil)
    end

    it "checks number of columns in each row" do
      expect(game.@board.[0].size).to eql(8)
    end

  end

  
  # rows
  #random positions
  #number of oclumns 

  describe "#update" do
    it "updates cell A4 to 'X' " do
      game.@board.update_method(7, 4, "X" )
      expect(game.@board[7][3]).to eql("X")
    end
  
    it "udpates cell f7 to 'O' " do
      game.@board.update(2, 7, "O")
      expect(game.@board[2][6]).to eql("O")
    end

    it "tries to update H9 but fails" do
      game.@board.update(0, 9, "P")
      expect(game.@board[0][8]).to eql("P")
    end
  end

end