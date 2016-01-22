require_relative 'board'

class Player
  attr_accessor :name, :mark, :order

  def initialize(name = nil, mark = nil, order = 1)
    @name = name
    @mark = mark
    @order = order
  end

  def is_human?(player)
    player.name != "Computer" && player.name != "Computer 1" && player.name != "Computer 2"
  end

  def player_move(player, board, view)
    valid_move = false
    until valid_move
      move = view.get_player_move(player, board)
      valid_move = board.place(player, move)
      view.clear_screen!
      view.invalid_move_message(board) unless valid_move
    end
    move
  end

  def identify_computer_players(players)
    players.find_all{|player| player.name.include?("Computer")}
  end

  def player_board(board)
    board.each_index.select{|i| board[i] == mark}
  end

  def computer_move(players, board, view)
    computers = identify_computer_players(players)
    computers.each do |computer|
      move = board.best_available(players, computer)
      view.show_computer_selecting(computer, board)
      until board.open_space?(move)
        move = board.best_available(players, computer)
      end
      board.place(computer, move)
      view.display_computer_selection(computer, board, move)
      break if board.winner(players)
      break if board.tie?(players)
    end
  end

  def select_move_type(players, player, view, board)
    if is_human?(player)
      player_move(player, board, view)
    else
      computer_move(players, board, view)
      view.clear_screen!
    end
  end
end
