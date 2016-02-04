class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other)
    grade > other.grade
  end

  protected
  attr_reader :grade
end

joe = Student.new('Joe', 90)
bob = Student.new('Bob', 80)
puts "Well done!" if joe.better_grade_than?(bob)
