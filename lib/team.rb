class Team
  attr_reader :country,
              :players

  def initialize(country)
    @country    = country
    @eliminated = false
    @players    = []
  end

  def eliminated?
    @eliminated
  end

  def eliminated
    @eliminated = true
  end

  def active?
    !eliminated?
  end

  def add_player(player)
    @players << player
  end

  def players_by_position(position)
    @players.find_all { |player| player.position == position }
  end

  # def players 

  # end
end 