require './lib/player'
require 'stringio'

# def new_player_name
#   $stdin.gets.chomp
# end

# def new_player_symbol
#   $stdin.gets.chomp
# end

describe Player do

  before :all do
    @player_one = Player.new("Sam","X")
    @player_two = Player.new("Dean", "O")
    # $stdin = StringIO.new("Castiel")
    # $stdin = StringIO.new("A")
  end

  # after do 
  #   $stdin = STDIN
  # end

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

 

  describe "#create_player" do
    before do 
      # io_obj = double
      # expect(subject)
      #   .to receive (:gets)
      #   .and_return(io_obj)
      #   .twic:error
      # expect(io_obj)
      #   .to receive(:chomp)
      #   .and_return ("Castiel")
      # expect(io_obj)
      #   .to receive(:chomp)
      #   .and_return("A")


      player_name = double("player_name")
      allow($stdin).to receive(:gets).and_return(player_name)
      expect(player_name).to receive(:chomp).and_return("Castiel")

      player_symbol = double("player_symbol")
      allow($stdin).to receive(:gets).and_return(player_symbol)
      expect(player_symbol).to receive(:chomp).and_return("A")
    end

    it "asks for player's name and player's symbol" do

      Player.create_player

    expect(Player.player_list[2].name).to eql("Castiel")
    end
  end

end

#Edge cases
# - Duplicate names
# Duplicate symbols
# Require minimum of two players
# What cases would a double be appropriate? 