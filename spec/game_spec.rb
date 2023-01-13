require './lib/game'
require './lib/player'

describe Game do
  describe "#validate_players" do
    describe "when user responds no" do 
      it "resets the players" do
        allow(InputPrompt).to receive(:ask).with("How many players will be playing?").and_return('2')
        
        tic_tac_toe = Game.new("tic_tac_toe")
        allow($stdin).to receive(:gets).and_return('bob')
        allow($stdin).to receive(:gets).and_return('X')
        allow($stdin).to receive(:gets).and_return('mary')
        allow($stdin).to receive(:gets).and_return('O')

        allow($stdin).to receive(:gets).and_return('no')
        tic_tac_toe.validate_players
        
        expect(Player.player_list).to eql([])

      end
    end
  end
end