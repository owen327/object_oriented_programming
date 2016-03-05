class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
# What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer # Undefined method because manufacturer is a class method
tv.model

Television.manufacturer
Television.model # Undefined method because manufacturer is an instance method
