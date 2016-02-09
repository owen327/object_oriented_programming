class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run                # => "running!"
p pete.speak rescue             # => NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
p kitty.fetch rescue            # => NoMethodError

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim

p Bulldog.ancestors
# The method look up path is the order in which methods are looked up
