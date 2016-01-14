require_relative 'board'
require_relative 'player'
require_relative 'view'

class Game
  attr_accessor :players, :type
  attr_reader :board

  def initialize
    @players = [Player.new, Player.new("Computer")]
    @view = View.new
    @board = Board.new(9)
    @active_board = @board.active_board
    @type = nil
  end

  def setup_game
    @view.clear_screen!
    @view.get_player_name(@players[0])
    get_board_pieces
    game_type_selection
    unless @type == "3"
      @view.display_order_options(@players[0])
      player_order_selection
      @view.confirm_player_order(@players[0])
    end
    sleep(2.0)
  end

  def two_unique_pieces(marks)
    marks.length == 2 && marks.uniq.length > 1
  end

  def assign_pieces(players, marks)
    players[0].mark = marks[0]
    players[1].mark = marks[1]
  end

  def check_for_valid_pieces(marks, players)
    if two_unique_pieces(marks)
      assign_pieces(players, marks)
    else
      @view.display_invalid_char_message
    end
  end

  def get_board_pieces
    @view.display_pieces_prompt
    marks = []
    until two_unique_pieces(marks)
      marks = @view.get_pieces
      check_for_valid_pieces(marks, players)
    end
    puts
  end

  def game_type_selection
    @view.display_game_options
    @type = @view.get_user_input
    if @type == "1"
      @view.confirm_player_vs_comp
    elsif @type == "2"
      @view.confirm_player_vs_player(@players)
    elsif @type == "3"
      @view.confirm_comp_vs_comp(@players)
    else
      @view.display_invalid_selection_message
      game_type_selection
    end
    puts
  end

  def reverse_player_order
    @players[0].order = 2
    @players = @players.reverse
  end

  def player_order_selection
    order = @view.get_user_input.to_i
    until order == 1 || order == 2
      @view.display_invalid_selection_message
      @view.display_order_options(@players[0])
      order = @view.get_user_input.to_i
    end
    if order == 2
      reverse_player_order
    end
    puts
  end

  def play_game
    setup_game
    @view.clear_screen!
    until @board.game_finished?(@players)
      @players.each do |player|
        @board.print_board(@board.active_board)
        player.select_move_type(@players, player, @view, @board)
        break if @board.winner(@players)
        break if @board.tie?(@players)
      end
    end
    @view.display_results(@board, @players)
  end
end
