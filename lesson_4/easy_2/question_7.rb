class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# @@cats_count is a class variable which keeps count of number of Cat objects being instantiated

Cat.new("Tabby")
puts Cat.cats_count

Cat.new('shorthair')
puts Cat.cats_count
