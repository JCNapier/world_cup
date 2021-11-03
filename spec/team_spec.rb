require "rspec"
require './lib/player'
require "./lib/team"

describe Team do
  let(:team) {Team.new("France")}
  let(:mbappe) {Player.new({name: "Kylian Mbappe", position: "forward"})}
  let(:pogba) {Player.new({name: "Paul Pogba", position: "midfielder"})}

  it 'exists' do
    expect(team).to be_an_instance_of(Team)
  end

  it 'attributes' do
    expect(team.country).to eq("France")
  end

  it 'can be eliminated' do
    expect(team.eliminated?).to be(false)

    team.eliminated

    expect(team.eliminated?).to be(true)
  end

  it 'has players' do
    expect(team.players).to eq([])
  end

  it 'can add players' do
    team.add_player(mbappe)
    team.add_player(pogba)

    expect(team.players).to eq([mbappe, pogba])
  end

  it 'can return players by position' do
    team.add_player(mbappe)
    team.add_player(pogba)
    
    expect(team.players_by_position("midfielder")).to eq([pogba])
    expect(team.players_by_position("defender")).to eq([])
  end
end
