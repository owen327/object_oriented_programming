class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name # @name is an instance variable
  end
end

p Pizza.new("Peperoni").instance_variables
p Fruit.new("Apple").instance_variables
