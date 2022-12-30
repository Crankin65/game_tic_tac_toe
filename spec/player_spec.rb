require './lib/player'

describe Player do

  before :all do
    @player_one = Player.new("Sam","X")
    @player_two = Player.new("Dean", "O")
  end

  describe "#name" do
    it "returns the name of the player" do
      expect(@player_one.name).to eql("Sam")
    end
  end

  describe "#self.player_list.length" do 
    it "returns the total number of players playing" do
      expect(Player.player_list.length).to eql(2)
    end
  end   

  describe "self.player_names" do
    it "creates an array of player names" do
     expect(Player.player_names).to eql(["Sam","Dean"])
    end
  end

  describe "remove_one_player" do 
    it "removes one player from player list" do
      Player.remove_one_player("Sam")  
      expect(Player.player_list[0].name).to eql("Dean")
    end
  end

  describe "reset_players" do
    it "removes all players from player list" do
      Player.reset_players
      expect(Player.player_list.length).to eql(0)
    end
  end

end
