class Move
  VALUES = %w(rock paper scissors lizard spock)

  def scissors?
    self.class == Scissors
  end

  def rock?
    self.class == Rock
  end

  def paper?
    self.class == Paper
  end

  def lizard?
    self.class == Lizard
  end

  def spock?
    self.class == Spock
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
  end

  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def <(other_move)
    other_move.paper? || other_move.spock?
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
  end

  def >(other_move)
    other_move.rock? || other_move.spock?
  end

  def <(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
  end

  def >(other_move)
    other_move.paper? || other_move.lizard?
  end

  def <(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def >(other_move)
    other_move.spock? || other_move.paper?
  end

  def <(other_move)
    other_move.rock? || other_move.scissors?
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
  end

  def >(other_move)
    other_move.scissors? || other_move.rock?
  end

  def <(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class Player
  attr_accessor :move, :name, :score, :history

  def initialize
    set_name
    @score = 0
    @history = []
  end

  def set_move(choice)
    self.move = case choice
                when 'rock' then Rock.new
                when 'paper' then Paper.new
                when 'scissors' then Scissors.new
                when 'lizard' then Lizard.new
                when 'spock' then Spock.new
                end
  end
end

class Human < Player
  def set_name
    loop do
      puts "What's your name?"
      self.name = gets.chomp.capitalize
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
  end

  def choose
    choice = nil
    loop do
      system 'clear'
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    set_move(choice)
  end
end

class Computer < Player
  attr_accessor :win_history

  def initialize
    super
    @win_history = []
  end

  def set_name
    self.name = %W(R2D2 Hal Chappie Sonny Number\s5).sample
  end

  def choose
    if @win_history.size > 3
      choice = (Move::VALUES + @win_history).sample
    else
      choice = choose_by_personality
    end
    set_move(choice)
  end

  def choose_by_personality
    num = Random.new.rand(100) + 1
    case name
    when 'R2D2'
      'rock'
    when 'Hal'
      if (1..75).include?(num)
        'scissors'
      else
        'rock'
      end
    when 'Chappie'
      if (1..50).include?(num)
        'paper'
      else
        'rock'
      end
    when 'Sonny'
      if (1..40).include?(num)
        'scissors'
      elsif (41..80).include?(num)
        'rock'
      else
        'paper'
      end
    when 'Number 5'
      Move::VALUES.sample
    end
  end
end

# Game Orchestration Engine
class RPSGame
  WIN_SCORE = 10

  attr_accessor :human, :computer

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    system 'clear'
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    loop do
      puts "Would you like to play again? Enter 'y' for yes:"
      return gets.chomp.downcase == "y" ? true : false
    end
  end

  def update_scores
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    end
  end

  def display_scores
    puts '*' * 80
    puts "#{human.name} score: #{human.score}"
    puts "#{computer.name} score: #{computer.score}"
    puts '*' * 80
  end

  def win_score_reached?
    human.score == WIN_SCORE || computer.score == WIN_SCORE
  end

  def update_history
    human.history << human.move.to_s
    computer.history << computer.move.to_s
  end

  def display_history
    puts "#{human.name}'s history: #{human.history}"
    puts "#{computer.name}'s history: #{computer.history}"
  end

  def update_computer_win_history
    computer.win_history << computer.move.to_s if human.move < computer.move
  end

  def play
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      update_history
      update_computer_win_history
      update_scores
      display_scores
      break if win_score_reached? || !play_again?
    end
    display_history
    display_goodbye_message
  end
end

RPSGame.new.play
