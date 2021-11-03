require "rspec"
require './lib/player'
require "./lib/team"
require "./lib/world_cup"

describe WorldCup do
  let(:world_cup) {WorldCup.new(2018, [france, croatia])}
  let(:france) {Team.new("France")}
  let(:croatia) {Team.new("Croatia")}
  let(:mbappe) {Player.new({name: "Kylian Mbappe", position: "forward"})}
  let(:pogba) {Player.new({name: "Paul Pogba", position: "midfielder"})}
  let(:modric) {Player.new({name: "Luka Modric", position: "midfielder"})}
  let(:vida) {Player.new({name: "Domagoj Vida", position: "defender"})}

  before(:each) do
    france.add_player(mbappe)
    france.add_player(pogba)
    croatia.add_player(modric)
    croatia.add_player(vida)
  end

  it 'exists' do
    expect(world_cup).to be_an_instance_of(WorldCup)
  end

  it 'attributes' do
    expect(world_cup.year).to eq(2018)
    expect(world_cup.teams).to eq([france, croatia])
  end

  it 'can return active players by position' do
    expect(world_cup.active_players_by_position("midfielder")).to eq([pogba, modric])

    croatia.eliminated

    expect(world_cup.active_players_by_position("midfielder")).to eq([pogba])
  end

  it 'can return all players by position' do
    expected = {
      "forward" => [mbappe],
      "midfielder" => [pogba, modric],
      "defender" => [vida]
    }

    expect(world_cup.all_players_by_position).to eq(expected)
  end
end
