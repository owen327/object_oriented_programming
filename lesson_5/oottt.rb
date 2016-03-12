class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def [](num)
    @squares[num]
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def draw
    puts <<-DISPLAY_BOARD
     \u{2502}     \u{2502}
  #{@squares[1]}  \u{2502}  #{@squares[2]}  \u{2502}  #{@squares[3]}
     \u{2502}     \u{2502}
#{"\u{23BC}" * 5}\u{253C}#{"\u{23BC}" * 5}\u{253C}#{"\u{23BC}" * 5}
     \u{2502}     \u{2502}
  #{@squares[4]}  \u{2502}  #{@squares[5]}  \u{2502}  #{@squares[6]}
     \u{2502}     \u{2502}
#{"\u{23BC}" * 5}\u{253C}#{"\u{23BC}" * 5}\u{253C}#{"\u{23BC}" * 5}
     \u{2502}     \u{2502}
  #{@squares[7]}  \u{2502}  #{@squares[8]}  \u{2502}  #{@squares[9]}
     \u{2502}     \u{2502}
    DISPLAY_BOARD
  end

  def possible_win?(marker)
    WINNING_LINES.find do |line|
      @squares.values_at(*line).map(&:marker).count(marker) == 2 &&
        @squares.values_at(*line).count(&:unmarked?) == 1
    end
  end

  def locate_winning_square(marker)
    possible_win?(marker).find { |square| @squares[square].unmarked? }
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    markers.size == 3 && markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :name
  attr_accessor :score

  def initialize(name, marker)
    @marker = marker
    @name = name
    reset_score
  end

  def reset_score
    @score = 0
  end
end

class TTTGame
  X_MARKER = 'X'
  O_MARKER = 'O'

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(get_human_name, get_human_marker)
    @computer = Player.new(get_computer_name, get_computer_marker)
    @first_player = get_first_player
    @current_marker = @first_player
  end

  def play
    clear
    display_welcome_message

    loop do
      loop do
        display_board

        loop do
          current_player_moves
          break if board.someone_won? || board.full?
          clear_screen_and_display_board
        end

        display_result_of_round
        increment_score
        display_scores
        puts "Press enter to continue:"
        gets

        break if human.score >= 5 || computer.score >= 5
        reset_board
      end

      display_result_of_round
      display_final_results
      break unless play_again?
      reset_scores
      reset_board
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def get_human_name
    name = ''
    loop do
      puts "Please enter your name: "
      name = gets.chomp.capitalize
      break if !name.empty?
      puts "Invalid!"
    end
    name
  end

  def get_computer_name
    ["Megatron", "Soundwave", "Holly", "R2-D2", "Siri"].sample
  end

  def get_first_player
    human_first = ''
    loop do
      puts "Do you want to go first? (y/n): "
      human_first = gets.chomp.upcase
      break if human_first == "Y" || human_first == "N"
      puts "Please enter 'X' or 'O'"
    end
    return human.marker if human_first == "Y"
    computer.marker
  end

  def get_human_marker
    marker = ""
    loop do
      puts "Choose your marker 'X' or 'O':"
      marker = gets.chomp.upcase
      break if marker == "X" || marker == "O"
      puts "Please enter 'X' or 'O':"
    end
    marker
  end

  def get_computer_marker
    return 'O' if human.marker == 'X'
    'X'
  end

  def display_scores
    puts "The scores are #{human.name}: #{human.score}; #{computer.name}: #{computer.score}."
  end

  def increment_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!".center(80, "*")
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!".center(80, "*")
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "#{human.name}'s marker is #{human.marker}"
    puts "#{computer.name}'s marker is #{computer.marker}"
    puts
    board.draw
    puts
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "

    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def joinor(arr, delimiter=', ', word='or')
    return arr.join if arr.size == 1
    arr[0..-2].join(delimiter) << ", #{word} #{arr[-1]}."
  end

  def computer_moves
    square = if board.possible_win?(computer.marker)
               board.locate_winning_square(computer.marker)
             elsif board.possible_win?(human.marker)
               board.locate_winning_square(human.marker)
             elsif board[5].unmarked?
               5
             else
               board.unmarked_keys.sample
             end
    board[square] = computer.marker
  end

  def display_result_of_round
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won this round!"
    when computer.marker
      puts "#{computer.name} won this round!"
    else
      puts "This round is a tie!"
    end
  end

  def display_final_results
    case
    when human.score == 5
      puts "#{human.name} has reached 5 points and has won this game!".center(80, "*")
    when computer.score == 5
      puts "#{computer.name} has reached 5 points and has won this game!".center(80, "*")
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

  def reset_board
    board.reset
    @current_marker = @first_player
    clear
  end

  def reset_scores
    @human.reset_score
    @computer.reset_score
  end

  def display_play_again_message
    puts "Let's play again!\n "
  end

  def current_player_moves
    if @current_marker == human.marker
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def clear
    system "clear"
  end
end

game = TTTGame.new
game.play
