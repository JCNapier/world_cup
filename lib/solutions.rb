class Player
  attr_reader :name,
              :position

  def initialize(player_data)
    @name     = player_data[:name]
    @position = player_data[:position]
  end
end



describe Player do

  it 'exists' do
    player = Player.new({name: "Luka Modric", position: "midfielder"})

    expect(player).to be_an_instance_of(Player)
  end

  it 'has a name & position' do
    player = Player.new({name: "Luka Modric", position: "midfielder"})

    expect(player.name).to eq("Luka Modric")
    expect(player.position).to eq("midfielder")
  end
end


class Team
  attr_reader :country, :players
  attr_writer :eliminated

  def initialize(country)
    @country    = country
    @eliminated = false
    @players    = []
  end

  def eliminated?
    @eliminated
  end

  def add_player(players)
    @players.push(players)
  end

  def players_by_position(position)
    # valid_players = []
    #
    # @players.each do |player|
    #   if player.position == position
    #     valid_players << player
    #   end
    # end
    # valid_players

    @players.find_all do |player|
      player.position == position
    end
  end
end



describe Team do
  it 'exists' do
    team = Team.new("France")

    expect(team).to be_an_instance_of(Team)
    expect(team.country).to eq("France")
  end

  it 'is not eliminated by defalut' do
    team = Team.new("France")

    expect(team.eliminated?).to be(false)

    team.eliminated

    expect(team.eliminated).to eq(true)
  end

  it 'has no players by default' do
    team = Team.new("France")

    expect(team.players).to eq([])
  end

  it 'can have players' do
    team = Team.new("France")
    mbappe = Player.new({name: "Kylian Mbappe", position: "forward"})
    pogba = Player.new({name: "Paul Pogba", position: "midfielder"})

    team.add_player(mbappe)
    team.add_player(pogba)

    expect(team.players).to eq([mbappe, pogba])
  end

  it 'can have players with different positions' do
    team = Team.new("France")
    mbappe = Player.new({name: "Kylian Mbappe", position: "forward"})
    pogba = Player.new({name: "Paul Pogba", position: "midfielder"})

    team.add_player(mbappe)
    team.add_player(pogba)

    expect(team.players_by_position("midfielder")).to eq([pogba])
    expect(team.players_by_position("defender")).to eq([])
  end
end



class WorldCup
  attr_reader :year,
              :teams

  def initialize(year, teams)
    @year = year
    @teams = teams
  end

  def active_players_by_position(position)
    all_valid_players = []

    @teams.each do |team|
      if team.eliminated? != true
        all_valid_players << team.players_by_position(position)
      end
    end

    all_valid_players.flatten
  end

  def all_players_by_position
    all_players = {}

    @teams.each do |team|
      team.players.each do |player|
        if all_players[player.position].nil?
          all_players[player.position] = []
        end
        all_players[player.position] << player
      end
    end

    all_players
  end
end



describe WorldCup do
  it 'exists' do
    france = Team.new("France")
    mbappe = Player.new({name: "Kylian Mbappe", position: "forward"})
    pogba = Player.new({name: "Paul Pogba", position: "midfielder"})

    france.add_player(mbappe)
    france.add_player(pogba)

    croatia = Team.new("Croatia")
    modric = Player.new({name: "Luka Modric", position: "midfielder"})
    vida = Player.new({name: "Domagoj Vida", position: "defender"})

    croatia.add_player(modric)
    croatia.add_player(vida)

    world_cup = WorldCup.new(2018, [france, croatia])
    expect(world_cup).to be_an_instance_of(WorldCup)
    expect(world_cup.year).to eq(2018)
    expect(world_cup.teams).to eq([france, croatia])
  end

  it 'can list active players by position' do
    france = Team.new("France")
    mbappe = Player.new({name: "Kylian Mbappe", position: "forward"})
    pogba = Player.new({name: "Paul Pogba", position: "midfielder"})

    france.add_player(mbappe)
    france.add_player(pogba)

    croatia = Team.new("Croatia")
    modric = Player.new({name: "Luka Modric", position: "midfielder"})
    vida = Player.new({name: "Domagoj Vida", position: "defender"})

    croatia.add_player(modric)
    croatia.add_player(vida)

    world_cup = WorldCup.new(2018, [france, croatia])

    expect(world_cup.active_players_by_position("midfielder")).to eq([pogba, modric])

    croatia.eliminated = true

    expect(world_cup.active_players_by_position("midfielder")).to eq([pogba])
  end
end
