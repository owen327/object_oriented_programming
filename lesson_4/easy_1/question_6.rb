class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end

  def get_volume
    @volume
  end
end

p Cube.new(5000).instance_variable_get("@volume")
p Cube.new(4000).instance_variable_get(:@volume)
p Cube.new(3000).get_volume
p Cube.new(2000).volume
