require_relative 'board'
require_relative 'player'
require_relative 'view'

class Game
  attr_accessor :players
  attr_reader :board

  def initialize
    @players = [Player.new, Player.new("Computer")]
    @view = View.new
    @board = Board.new(9)
    @active_board = @board.active_board
  end

  def setup_game
    @view.clear_screen!
    puts @view.display_name_prompt
    @view.assign_player_name(@players[0])
    puts

    puts @view.display_pieces_prompt
    marks = @view.confirm_valid_pieces
    @view.assign_pieces_to_player(@players, marks)
    puts

    puts @view.display_game_options
    selection = @view.get_user_input
    type = @view.confirm_valid_type(selection)
    puts
    sleep(1.0)
    puts @view.display_game_confirmation(type)
    puts

    @view.assign_opponent(type, @players)
    @view.set_demo_players(type, @players)
    puts

    unless type == "3"
      puts @view.display_order_options(@players[0])
      selection = @view.get_user_input
      order = @view.confirm_valid_order(selection)
      if order == "2"
        @players.reverse!
      end
      puts
      puts @view.display_order_confirmation(@players[0])
    end
    sleep(2.0)
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
