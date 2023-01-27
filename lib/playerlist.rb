require './lib/player'
class Playerlist
  attr_reader :game
  attr_accessor :list
  def initialize
    @list = []
  end

  def reset_players
    @list = []
  end

  def add_player(player)
    @list << player
  end

  def remove_one_player(delete_name)
    index_to_delete = @list.find_index do |player|
      player.name == delete_name
    end
    @list.delete_at(index_to_delete)
  end

  def player_names
    name_array = []
    @list.map do |player|
      name_array << player.name
    end
    name_array
  end

  def player_names_and_symbols
    @list.each do |player|
      puts " #{player.name} is playing and is using '#{player.symbol}' as their symbol. \n"
    end
  end

end
