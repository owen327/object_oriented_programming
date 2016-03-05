# class Computer
#   attr_accessor :template
#
#   def create_template
#     @template = "template 14231"
#   end
#
#   def show_template
#     template
#   end
# end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    template
  end
end

my_computer = Computer.new
my_computer.create_template
puts my_computer.show_template

#Both do the same but first uses @template, second uses self.template
