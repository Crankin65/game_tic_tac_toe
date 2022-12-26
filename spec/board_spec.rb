require './lib/board'

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
      expect(game.puts_display).to eql(expected_display)
    end
  end

end