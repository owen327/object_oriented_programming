class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    "Don't start yet"
  end
end

puts Bingo.new.play #=> "Don't start yet"
