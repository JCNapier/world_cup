class WorldCup
  attr_reader :year,
              :teams

  def initialize(year, teams)
    @year  = year
    @teams = teams
  end

  def active_teams 
    # @teams.find_all { |team| team.active? }  
    @teams.find_all(&:active?)
  end

  def active_players 
    active_teams.reduce([]) do |array, team|
     team.players.each do |player|
      array << player
     end
     array
    end
  end

  def active_players_by_position(position)
     active_players.find_all { |player| player.position == position }
  end

  def positions
    @teams.map do |team|
      team.players.map do |player|
        player.position
      end
    end.flatten.uniq
  end

  def all_players 
    @teams.map do |team|
      team.players
    end.flatten
  end

  def all_players_by_position
    positions.reduce({}) do |hash, position|
      hash[position] = all_players.find_all {|player| player.position == position}
      hash
    end 
  end
end

#  @teams.each do |team|
        # team.players.each do |player|
        #   if player.position == position
        #     name << player
        #   end
        # end
        # all_players.find_all {|player| player.position == position}
        # require 'pry'; binding.pry
    end 