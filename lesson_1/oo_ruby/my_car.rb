module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
    if pounds < 2000
      puts "Your truck can tow #{pounds} pounds."
    else
      puts "Your truck cannot tow #{pounds} pounds."
    end
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  @@number_of_vehicles = 0


  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(new_color)
    self.color = new_color
    puts "You new #{color} paint job looks great!"
  end

  def age
    "Your #{self.model} is #{years_old} years old."
  end

  private

  def years_old
  #  require 'pry';binding.pry
    Time.now.year - year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{color}, #{year}, #{model}!"
  end
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{color}, #{year}, #{model}!"
  end
end

lumina = MyCar.new(1997, 'chevy lumina', 'white')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_down
lumina.current_speed
lumina.color = 'black'
puts lumina.color
puts lumina.year
lumina.spray_paint('black')
puts lumina.color
MyCar.gas_mileage(13, 351)
my_car = MyCar.new(2010, "Ford Focus", "silver")
puts my_car
Vehicle.number_of_vehicles
nissan = MyTruck.new(2000, "Titan", "red")
nissan.can_tow?(3000)
puts '-----'
puts MyCar.ancestors
puts '-----'
puts MyTruck.ancestors
puts '-----'
puts Vehicle.ancestors
puts '-----'
puts nissan.age
