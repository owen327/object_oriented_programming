class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_information # Light.information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end
