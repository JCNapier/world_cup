require "rspec"
require "./lib/player"

describe Player do
  let(:player) {Player.new({name: "Luka Modric", position: "midfielder"})}

  it 'exists' do
    expect(player).to be_an_instance_of(Player)
  end

  it 'attributes' do
    expect(player.name).to eq("Luka Modric")
    expect(player.position).to eq("midfielder")
  end
end
