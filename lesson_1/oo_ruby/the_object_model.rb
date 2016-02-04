module MyModule
  def display(name)
    puts name
  end
end

my_object = "String object"
my_second_object = String.new "String object"

class MyThirdObject
  include MyModule
end

my_third_object = MyThirdObject.new()
my_third_object.display("Owen")

# Modules are used to group together common methods and namespacing.
