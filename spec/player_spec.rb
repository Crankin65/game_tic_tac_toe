require './lib/player'
require 'stringio'

describe Player do

  before do
    player_one = Player.new("Sam","X")
    player_two = Player.new("Dean", "O")
  end

  describe "#name" do
    it "returns the name of the player" do
      expect(player_one.name).to eql("Sam")
    end
  end

  describe "#self.player_list.length"
    it "returns the total number of players playing"
      expect(Player.player_list.length).to eql(2)
    end
  end   

  describe "remove_one_player"
    it "removes one player from player list"
      Player.remove_one_player("Sam")  
      expect(Player.player_list[0].name).to eql("Dean")
    end
  end

  describe "reset_players"
    it "removes all players from player list"
      Player.reset_players
      expect(Player.player_list.length).to eql(0)
    end
  end

  describe "self.player_names"
    it "creates an array of player names"
     expect(Player.player_names).to eql(["Sam","Dean"])
    end
  end

  describe "create_player"
    it "creates a new player"
    end
  end

end

#Edge cases
# - Duplicate names
# Duplicate symbols
# Require minimum of two players