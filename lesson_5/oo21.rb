class Player
  attr_accessor :cards, :name
  def initialize
    @cards = []
    @name = get_name
  end

  def busted?
    total > 21
  end

  def total
    values = cards.map do |card|
      card.face.gsub(/[AKQJT]/, 'A' => 11, 'K' => 10, 'Q' => 10,
                                'J' => 10, 'T' => 10).to_i
    end
    total = values.reduce(:+)
    values.count(11).times { total -= 10 if total > 21 }
    total
  end

  def display_hand
    puts " #{name}'s cards: ".center(30, "-")
    puts cards
    puts "Total: #{total}"
    puts
  end
end

class Human < Player
  def get_name
    name = ''
    loop do
      puts "Please enter your name: "
      name = gets.chomp.capitalize
      break if !name.empty?
      puts "Your entry is invalid, try again."
    end
    name
  end
end

class Dealer < Player
  def get_name
    ["Megatron", "Soundwave", "T-1000", "R2D2", "Siri"].sample
  end
end

class Deck
  SUITS = %W(\u{2660} \u{2665} \u{2663} \u{2666})
  FACES = %w(2 3 4 5 6 7 8 9 T J Q K A)

  attr_accessor :cards

  def initialize
    @cards = []
    SUITS.each { |suit| FACES.each { |face| @cards << Card.new(suit, face) } }
    @cards.shuffle!
  end
end

class Card
  attr_reader :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def show_blank
    Card.new('?', '?')
  end

  def to_s
    <<-CARD
 \u{250F}\u{2501}\u{2513}
 \u{2503}#{@suit}\u{2503}
 \u{2503}#{@face}\u{2503}
 \u{2517}\u{2501}\u{251B}
    CARD
  end
end

class Game
  attr_reader :human, :dealer
  attr_accessor :deck

  def initialize
    @human = Human.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def deal_cards
    2.times { human.cards << @deck.cards.pop }
    2.times { dealer.cards << @deck.cards.pop }
  end

  def show_initial_cards
    human.display_hand
    puts " #{dealer.name}'s cards: ".center(30, "-")
    puts dealer.cards.first.show_blank
    puts dealer.cards.last
    puts "Total: ??"
    puts
  end

  def display_welcome_message
    system 'clear'
    puts " Welcome to Twenty-One! ".center(80, "*")
  end

  def display_goodbye_message
    puts " Thanks for playing Twenty-One. Goodbye! ".center(80, "*")
  end

  def hit_or_stay
    loop do
      puts "Enter 'h' to hit 's' to stay?"
      answer = gets.chomp.downcase
      return answer if answer == 'h' || answer == 's'
      puts "Your answer is invalid. Please try again..."
    end
  end

  def human_turn
    puts "It's #{human.name}'s turn..."

    loop do
      answer = hit_or_stay
      if answer == 's'
        puts "#{human.name} stays!"
        break
      end
      human.cards << deck.cards.pop
      puts "#{human.name} hits!"
      human.display_hand
      break if human.busted?
    end
  end

  def dealer_turn
    puts "It's #{dealer.name}'s turn...'"

    loop do
      if dealer.total >= 17 && !dealer.busted?
        puts "#{dealer.name} stays!"
        break
      elsif dealer.busted?
        break
      else
        puts "#{dealer.name} hits!"
        dealer.cards << deck.cards.pop
      end
    end
  end

  def show_result
    case
    when human.busted?
      puts "It looks like #{human.name} busted! #{dealer.name} wins!"
    when dealer.busted?
      puts "It looks like #{dealer.name} busted! #{human.name} wins!"
    when human.total > dealer.total
      puts "It looks like #{human.name} wins!"
    when dealer.total > human.total
      puts "It looks like #{dealer.name} wins!"
    else
      puts "It looks like it's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def reset
    self.deck = Deck.new
    human.cards = []
    dealer.cards = []
    system 'clear'
  end

  def start
    display_welcome_message
    loop do
      deal_cards
      show_initial_cards
      human_turn
      dealer_turn unless human.busted?
      puts 'Press enter to contintue...'
      gets
      system 'clear'
      human.display_hand
      dealer.display_hand
      show_result
      break unless play_again?
      reset
    end
    display_goodbye_message
  end
end

Game.new.start
