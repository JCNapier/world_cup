class Player
  attr_reader :name,
              :position
              
  def initialize(info)
    @name     = info[:name]
    @position = info[:position]
  end
end
