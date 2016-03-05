class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game # '< Game' to inherit
  def rules_of_play
    #rules of play
  end
end

puts Bingo.new.play
