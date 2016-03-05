class Cube
  def initialize(volume)
    @volume = volume
  end
end

cube = Cube.new(5000)
p cube.to_s #=> "#<Cube:0x00561fc5d56340>"
# From ruby-doc Returns a string representing obj. The default to_s prints the object’s class and an encoding of the object id. As a special case, the top-level object that is the initial execution context of Ruby programs returns “main”.
