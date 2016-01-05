BOARD_SIZE = 9

class Game
  attr_accessor :board, :players, :type

  def initialize
    @board_positions = (1..BOARD_SIZE).to_a.map{|n| n.to_s}
    @board = Array.new(BOARD_SIZE, " ")
    @players = [{name: nil, mark: nil, order: 1}, {name: "Computer", mark: nil, order: 1}]
    @type = nil
    @played_moves = []
    setup_game
  end

  def play_game
    until winner(@board) || tie
      @players.each do |player|
        puts
        if player[:name] != "Computer" && player[:name] != "Computer 1" && player[:name] != "Computer 2"
          player_move(player)
          print_board(@board)
        else
          computer_move
          print_board(@board)
        end
        break if winner(@board)
        break if tie
      end
    end
    if winner(@board)
      puts
      puts winner(@board) + " is the winner!"
    else
      puts
      puts "It's a tie."
    end
  end

  def setup_game
    get_player_name
    puts
    get_board_pieces
    puts
    display_game_options
    game_type_selection
    puts
    unless @type == "3"
      display_order_options
      player_order_selection
      puts
      puts "Alright, #{@players[0][:name]}, you are turn number #{@players[0][:order]}"
    end
    puts
    sleep(1.0)
    print_board(@board_positions)
    puts
  end

  def get_player_name
    puts "Player, what is your name?"
    if @players[0][:name] == nil
      @players[0][:name] = gets.chomp
    else
      @players[1][:name] = gets.chomp
    end
  end

  def get_board_pieces
    marks = []
    puts "Which 2 characters would you like to play with (ie: X, O)?"
    until marks.length == 2 && marks.uniq.length > 1
      marks = gets.chomp.gsub(/[\s,]/ ,"").chars
      if marks.length == 2 && marks.uniq.length > 1
        @players[0][:mark] = marks[0]
        @players[1][:mark] = marks[1]
      else
        puts "Please enter 2 valid characters (may not be the same)"
      end
    end
  end

  def display_game_options
    puts "Please select the mode of play: "
    puts "[1] You versus the computer"
    puts "[2] You versus another player"
    puts "[3] Demo computer versus computer"
  end

  def game_type_selection
    @type = gets.chomp
    if @type == "1"
      sleep(1.0)
      puts
      puts "The computer has accepted your challenge."
    elsif @type == "2"
      sleep(1.0)
      puts
      puts "Ok, you want to play against another person"
      get_player_name
    elsif @type == "3"
      sleep(1.0)
      puts
      puts "The computer will play against itself"
      @players[0][:name] = "Computer 1"
      @players[1][:name] = "Computer 2"
    else
      puts "Please make a valid selection"
      game_type_selection
    end
  end

  def display_order_options
    puts "#{@players[0][:name]}, do you want to go first or second?"
    puts "[1] First"
    puts "[2] Second"
  end

  def player_order_selection
    order = gets.chomp.to_i
    until order == 1 || order == 2
      puts "Please make a valid selection"
      display_order_options
      order = gets.chomp.to_i
    end
    if order == 2
      @players[0][:order] = 2
      @players = @players.reverse
    end
  end

  def place(piece, move)
    return false if move < 1 || move > BOARD_SIZE
    return false if @played_moves.include?(move)
    @board[move - 1] = piece
    @played_moves << move
  end

  def player_move(player)
    valid_move = false
    until valid_move
      puts "#{player[:name]}, enter your move:"
      move = gets.chomp.to_i
      puts
      unless move.between?(1,9)
        puts "Enter a valid move"
        next
      end
      valid_move = place(player[:mark], move)
      puts "Invalid move" unless valid_move
    end
  end

  def computer_move
    computers = @players.find_all{|player| player[:name].include?("Computer")}
    index = rand(0..8)
    computers.each do |computer|
      puts "#{computer[:name]} is selecting"
      3.times do
        print ". "
        sleep(1.0)
      end
      puts
      until @board[index] == " "
        index = rand(0..8)
      end
      @board[index] = computer[:mark]
      puts
      puts "#{computer[:name]} selected #{index + 1}"
      if computer[:name] == "Computer 1"
        puts
        print_board(@board)
      end
      @played_moves << index + 1
      puts
      break if winner(@board)
      break if tie
    end
  end

  def winner(board)
    winning_combinations = [[0, 1, 2], [3, 4, 5],
                            [6, 7, 8], [0, 3, 6],
                            [1, 4, 7], [2, 5, 8],
                            [0, 4, 8], [2, 4, 6]]
    winning_combinations.each do |row|
      if board.at(row[0]) == @players[0][:mark] &&
        board.at(row[1]) == @players[0][:mark] &&
        board.at(row[2]) == @players[0][:mark]
        return @players[0][:name]
      elsif board.at(row[0]) == @players[1][:mark] &&
        board.at(row[1]) == @players[1][:mark] &&
        board.at(row[2]) == @players[1][:mark]
        return @players[1][:name]
      end
    end
    return false
  end

  def tie
    !(@board.include?(" "))
  end

  def print_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} \n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]} \n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]}"
  end
end

game = Game.new
game.play_game