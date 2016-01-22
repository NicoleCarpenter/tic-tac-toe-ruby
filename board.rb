class Board
  attr_accessor :active_board, :winning_combinations, :played_moves
  attr_reader :board_positions

  def initialize(board_size)
    @board_size = board_size
    @rows = find_rows
    @board_positions = (1..square_board).to_a.map{|n| n.to_s}
    @active_board = Array.new(square_board, " ")
    @winning_combinations = []
    find_winning_combinations(@board_positions)
    @played_moves = []
  end

  def find_rows
    Math.sqrt(@board_size).floor
  end

  def square_board
    @rows**2
  end

  def separate_rows(board)
    board.each_slice(@rows).to_a
  end

  def separate_columns(board)
    separate_rows(board).transpose
  end

  def add_leading_space(slice)
    slice = slice.map do |number|
      if number.to_i / 10 < 1
        number = " " + number
      else
        number
      end
    end
  end

  def last_row(index)
    index == (@rows - 1)
  end

  def format_row(row)
    row.compact.join("")
  end

  def print_board(board)
    slices = separate_rows(board)
    row_fillers = Array.new((@rows - 1), " |")
    slices.each.with_index do |slice, index|
      slice = add_leading_space(slice)
      puts format_row(slice.zip(row_fillers))
      unless last_row(index)
        puts "===" + ("+===" * (@rows - 1))
      end
    end
    puts
  end

  def position_to_index(line)
    line = line.map do |position|
      position = (position.to_i - 1)
    end
  end

  def add_to_winning_combinations(combinations)
    combinations.each do |combination|
      @winning_combinations << combination
    end
  end

  def find_winning_rows(board)
    rows = separate_rows(board)
    rows.map do |row|
      position_to_index(row)
    end
  end

  def find_winning_columns(board)
    columns = separate_columns(board)
    columns.map do |column|
      position_to_index(column)
    end
  end

  def find_winning_diagonals(board)
    indexed_board = []
    separate_rows(board).each do |row|
      row = position_to_index(row)
      indexed_board << row
    end
    diagonals = (0..(indexed_board.length - 1)).collect { |i| indexed_board[i][i]}, (0..(indexed_board.length - 1)).collect { |i| indexed_board.reverse[i][i]}
  end

  def find_winning_combinations(board)
    add_to_winning_combinations(find_winning_rows(board))
    add_to_winning_combinations(find_winning_columns(board))
    add_to_winning_combinations(find_winning_diagonals(board))
    @winning_combinations
  end

  def place(player, move)
    return false if !valid_move?(move)
    return false if @played_moves.include?(move)
    @played_moves << move
    active_board[move - 1] = player.mark
  end

  def valid_move?(move)
    move.between?(1, square_board)
  end

  def open_space?(move)
    @active_board[move - 1] == " "
  end

  def random_move
    rand(1..(square_board))
  end

  def has_center_space?
    square_board % 2 != 0
  end

  def find_center_space
    if has_center_space?
      (square_board / 2) + 1
    end
  end

  def center_space_empty?
    center_space = find_center_space
    @active_board[center_space - 1] == " "
  end

  def find_corner_spaces
    corners = []
    position_board = separate_rows(board_positions)
    corners << position_board[0][0].to_i
    corners << position_board[0][-1].to_i
    corners << position_board[-1][0].to_i
    corners << position_board[-1][-1].to_i
    corners
  end

  def corner_space_empty?(board)
    corner_spaces = find_corner_spaces
    available = corner_spaces.find_all {|space| board[space - 1] == " "}
    if available.length == 0
      return false
    else
      return available
    end
  end

  def next_move_win(player)
    @winning_combinations.each do |combo|
      row_spots = combo - player.player_board(@active_board)
      if row_spots.length == 1
        move = row_spots.join.to_i + 1
        if open_space?(move)
          return move
        end
      end
    end
    false
  end

  def best_available(players, current_computer_player)
    opponent = players.find{|player| player != current_computer_player}
    player_win = next_move_win(current_computer_player)
    opponent_block = next_move_win(opponent)
    if center_space_empty?
      return find_center_space
    elsif player_win
      return player_win
    elsif opponent_block
      return opponent_block
    elsif corner_space_empty?(@active_board)
      return corner_space_empty?(@active_board).sample
    else
      random_move
    end
  end

  def winner(players)
    @winning_combinations.each do |combo|
      if (combo - players[0].player_board(@active_board)).empty?
        return players[0].name
      elsif (combo - players[1].player_board(@active_board)).empty?
        return players[1].name
      end
    end
    return false
  end

  def tie?(players)
    !winner(players) && !(@active_board.include?(" "))
  end

  def game_finished?(players)
    winner(players) || tie?(players)
  end
end
