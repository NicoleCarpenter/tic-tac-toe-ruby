require 'spec_helper'

describe Board do
  let(:board){Board.new(9)}

  describe '#find_rows' do
    context 'with a perfect square for board size' do
      it 'should return 3 rows for a board size of 9' do
        expect(board.find_rows).to eq(3)
      end
    end
    context 'with an imperfect square for board size' do
      it 'should return 4 rows for a board size of 17' do
        board = Board.new(17)
        expect(board.find_rows).to eq(4)
      end
    end
  end

  describe '#square_board' do
    context 'with a perfect square for board size' do
      it 'should return the board size' do
        expect(board.square_board).to eq(9)
      end
    end
    context 'with an imperfect square for board size' do
      it 'should return the closest perfect square rounded down' do
        board = Board.new(11)
        expect(board.square_board).to eq(9)
      end
    end
  end

  describe '#separate_rows' do
    sample_board = ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'X', 'O']
    it 'should return an array' do
      expect(board.separate_rows(sample_board)).to be_an(Array)
    end

    it 'the number of rows should equal the number of elements' do
      elements = board.separate_rows(sample_board).length
      expect(elements).to eq(3)
    end

    it 'the number of rows should equal the number of elements per nested array' do
      divided_board = board.separate_rows(sample_board)
      expect(divided_board[0].length).to eq(3)
      expect(divided_board[1].length).to eq(3)
      expect(divided_board[2].length).to eq(3)
    end
  end

  describe '#separate_columns' do
    sample_board = ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'X', 'O']
    it 'should return an array' do
      expect(board.separate_columns(sample_board)).to be_an(Array)
    end

    it 'the number of columns should equal the number of elements' do
      elements = board.separate_columns(sample_board).length
      expect(elements).to eq(3)
    end

    it 'the number of columns should equal the number of elements per nested array' do
      divided_board = board.separate_columns(sample_board)
      expect(divided_board[0].length).to eq(3)
      expect(divided_board[1].length).to eq(3)
      expect(divided_board[2].length).to eq(3)
    end
  end

  describe '#add_leading_space' do
    sample_slice = ['9', '10', '11']
    context 'input number is less than 10' do
      it 'should add a space before the number' do
        transformed = board.add_leading_space(sample_slice)
        expect(transformed[0]).to eq(' 9')
      end
    end
    context 'input number greater than or equal to 10' do
      it 'should leave double digits as they are' do
        transformed = board.add_leading_space(sample_slice)
        expect(transformed[2]).to eq('11')
      end
    end
  end

  describe '#last_row' do
    context 'last row' do
      it 'should return true' do
        expect(board.last_row(2)).to be(true)
      end
    end
    context 'not last row' do
      it 'should return false' do
        expect(board.last_row(0)).to be(false)
      end
    end
  end

  describe '#format_row' do
    sample_row = ["X", " |", " ", " |", "O", nil]
    it 'should return an string' do
      expect(board.format_row(sample_row)).to be_a(String)
    end
  end

  describe '#print_board' do
    sample_board = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    board = Board.new(16)
    xit 'should print the board as a string' do
      expect(board.print_board(sample_board)).to be_a(String)
    end
  end

  describe '#position_to_index' do
    line = ["9", "10", "11", "12"]
    it 'should change the position to its index' do
      expect(board.position_to_index(line)).to eq([8, 9, 10, 11])
    end
  end

  describe '#add_to_winning_combinations' do
    it 'should return an Array' do
      expect(board.winning_combinations).to be_an(Array)
    end

    it 'should add the combinations to winning_combinations' do
      combinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
      board.add_to_winning_combinations(combinations)
      expect(board.winning_combinations).to include(combinations[0])
      expect(board.winning_combinations).to include(combinations[1])
      expect(board.winning_combinations).to include(combinations[2])
    end
  end

  describe '#find_winning_rows' do
    context '3 x 3 board' do
      board = Board.new(9)
      board_positions = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      it 'should return an array' do
        expect(board.find_winning_rows(board_positions)).to be_an(Array)
      end

      it 'should return the winning rows' do
        expect(board.find_winning_rows(board_positions)).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
      end
    end

    context '4 x 4 board' do
      board = Board.new(16)
      board_positions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
      it 'should return an array' do
        expect(board.find_winning_rows(board_positions)).to be_an(Array)
      end

      it 'should return the winning rows' do
        expect(board.find_winning_rows(board_positions)).to eq([[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15]])
      end
    end
  end

  describe '#find_winning_columns' do
    context '3 x 3 board' do
      board = Board.new(9)
      board_positions = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      it 'should return an array' do
        expect(board.find_winning_columns(board_positions)).to be_an(Array)
      end

      it 'should return the winning columns' do
        expect(board.find_winning_columns(board_positions)).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
      end
    end

    context '4 x 4 board' do
      board = Board.new(16)
      board_positions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
      it 'should return an array' do
        expect(board.find_winning_columns(board_positions)).to be_an(Array)
      end

      it 'should return the winning columns' do
        expect(board.find_winning_columns(board_positions)).to eq([[0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15]])
      end
    end
  end

  describe '#find_winning_diagonals' do
    context '3 x 3 board' do
      board = Board.new(9)
      board_positions = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      it 'should return an array' do
        expect(board.find_winning_diagonals(board_positions)).to be_an(Array)
      end

      it 'should return the winning diagonals' do
        expect(board.find_winning_diagonals(board_positions)).to eq([[0, 4, 8], [6, 4, 2]])
      end
    end

    context '4 x 4 board' do
      board = Board.new(16)
      board_positions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
      it 'should return an array' do
        expect(board.find_winning_diagonals(board_positions)).to be_an(Array)
      end

      it 'should return the winning diagonals' do
        expect(board.find_winning_diagonals(board_positions)).to eq([[0, 5, 10, 15], [12, 9, 6, 3]])
      end
    end
  end

  describe '#find_winning_combinations' do
    context '3 x 3 board' do
      board = Board.new(9)
      board_positions = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      it 'should return an array' do
        expect(board.find_winning_combinations(board_positions)).to be_an(Array)
      end

      it 'should return the winning combinations' do
        expect(board.find_winning_combinations(board_positions)).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2], [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2], [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]])
      end
    end

    context '4 x 4 board' do
      board = Board.new(16)
      board_positions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
      it 'should return an array' do
        expect(board.find_winning_combinations(board_positions)).to be_an(Array)
      end

      it 'should return the winning combinations' do
        expect(board.find_winning_combinations(board_positions)).to eq([[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15], [0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [0, 5, 10, 15], [12, 9, 6, 3], [0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15], [0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [0, 5, 10, 15], [12, 9, 6, 3], [0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15], [0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [0, 5, 10, 15], [12, 9, 6, 3]])
      end
    end
  end

  describe '#place' do
    player = Player.new("Jessie", "X")
    it 'should reject a move if the spot has been played' do
      board.played_moves = [1, 3, 5, 6, 9]
      expect(board.place(player, 3)).to be(false)
    end

    it 'should add the move to played moves' do
      board.played_moves = [1, 3, 5, 6, 9]
      board.place(player, 4)
      expect(board.played_moves).to include(4)
    end

    it 'should change the value of board to the mark if valid move' do
      active_board = [' ', ' ', 'O', 'O', ' ', 'X', ' ', 'X', 'O']
      board.place(player, 1)
      expect(board.active_board[0]).to eq(player.mark)
    end
  end

  describe '#valid_move' do
    board_size = 9
    board = Board.new(board_size)
    context 'is a valid move' do
      it 'should be truthy if move is between 1 and board size' do
        expect(board.valid_move?(3)).to be_truthy
      end
    end

    context 'is not a valid move' do
      it 'should reject a move if it is below 1' do
        expect(board.valid_move?(-4)).to be(false)
      end
      it 'should reject a move if it is above board size' do
        expect(board.valid_move?(10)).to be(false)
      end
    end
  end

  describe '#open_space' do
    board = Board.new(9)
    board.active_board = ['X', 'X', 'X', ' ', ' ', ' ', ' ', ' ', ' ']
    context 'move is not an open space' do
      it 'should return false' do
        move = 2
        expect(board.open_space?(move)).to eq(false)
      end
    end
    context 'move is an open space' do
      it 'should return true' do
        move = 8
        expect(board.open_space?(move)).to eq(true)
      end
    end
  end

  describe '#random_move' do
    board = Board.new(9)
    it 'should return a board place' do
      expect(board.random_move).to be_an(Integer)
    end
    it 'should not be greater thanboard length' do
      expect(board.random_move).to be <= board.square_board
    end
  end

  describe '#has_center_space' do
    context 'There is a center space' do
      it 'should return true' do
        board = Board.new(9)
        expect(board.has_center_space?).to be(true)
      end
    end
    context 'There is a center space' do
      it 'should return true' do
        board = Board.new(16)
        expect(board.has_center_space?).to be(false)
      end
    end
  end

  describe 'find_center_space' do
    it 'should return the center space' do
      board = Board.new(9)
      expect(board.find_center_space).to eq(5)
    end
  end

  describe '#center_space_empty' do
    context 'center space has not been selected' do
      it 'should return true' do
        board.active_board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        expect(board.center_space_empty?).to be(true)
      end
    end
    context 'center space has already been selected' do
      it 'should return false' do
        board.active_board = ['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']
        expect(board.center_space_empty?).to be(false)
      end
    end
  end

  describe '#find_corner_spaces' do
    context '3 x 3 board' do
      it 'should return an array of the corner spaces' do
        expect(board.find_corner_spaces).to eq([1, 3, 7, 9])
      end
    end

    context '4 x 4 board' do
      board = Board.new(16)
      it 'should return an array of the corner spaces' do
        expect(board.find_corner_spaces).to eq([1, 4, 13, 16])
      end
    end
  end

  describe '#corner_space_empty' do
    context 'there are no empty corner spaces' do
      it 'should return false' do
        sample_board = ['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']
        expect(board.corner_space_empty?(sample_board)).to eq(false)
      end
    end

    context 'there is at least one empty corner space' do
      it 'should return an array with the available spaces' do
        sample_board = [' ', 'X', 'X', 'X', 'X', 'X', 'X', 'X', ' ']
        expect(board.corner_space_empty?(sample_board)).to eq([1, 9])
      end
    end
  end

  describe '#next_move_win' do
    player = Player.new("John", "X")
    context 'there is not a winning move' do
      it 'should return false' do
        board.active_board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        expect(board.next_move_win(player)).to eq(false)
      end
    end

    context 'there is a winning move' do
      it 'should return false' do
        board.active_board = ['X', 'X', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        expect(board.next_move_win(player)).to eq(3)
      end
    end
  end

  describe '#best_available' do
    players = [Player.new("Rick", "X"), Player.new("Computer", "O")]
    computer = players[1]
    context 'the computer can win' do
      it 'should return the winning place' do
        board.active_board = ['O', 'O', ' ', ' ', 'O', ' ', ' ', ' ', ' ']
        expect(board.best_available(players, computer)).to eq(3)
      end
    end
    context 'the opponent can win' do
      it 'should return the winning place' do
        board.active_board = ['X', 'X', ' ', ' ', 'O', ' ', ' ', ' ', ' ']
        expect(board.best_available(players, computer)).to eq(3)
      end
    end
    context 'the neither the opponent nor computer can win' do
      it 'should return the winning place' do
        board.active_board = ['O', 'O', 'X', ' ', ' ','O', ' ', ' ', ' ']
        expect(board.best_available(players, computer)).not_to eq(3)
      end
    end
  end

  describe '#winner' do
    players = [Player.new("Nicole", "X"), Player.new("Jason", "O")]
    context 'there is a winner' do
      it 'should return the board winner name' do
        board.active_board = ['X', 'X', 'X', ' ', ' ', ' ', ' ', ' ', ' ']
        expect(board.winner(players)).to eq("Nicole")
        board.active_board = ['O', ' ', ' ', 'O', ' ', ' ', 'O', ' ', ' ']
        expect(board.winner(players)).to eq("Jason")
      end
    end
    context 'there is no winner' do
      it 'should return false' do
        board.active_board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        expect(board.winner(players)).to eq(false)
      end
    end
  end

  describe '#tie' do
    context 'there is a tie' do
      it 'should return true' do
        players = [Player.new("Nicole", "X"), Player.new("Jason", "O")]
        board.active_board = ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'X', 'O']
        expect(board.tie?(players)).to be(true)
      end
    end
    context 'there is not a tie' do
      it 'should return false' do
        players = [Player.new("Nicole", "X"), Player.new("Jason", "O")]
        board.active_board = ['X', ' ', 'O', 'O', 'O', 'X', 'X', 'X', 'O']
        expect(board.tie?(players)).to be(false)
      end
    end
  end

  describe '#game_finished' do
    players = [Player.new("Nicole", "X"), Player.new("Jason", "O")]
    context 'there is a winner' do
      it 'should return true if there is a winner' do
        board.active_board = ['X', 'X', 'X', ' ', ' ', ' ', ' ', ' ', ' ']
        expect(board.game_finished?(players)).to be_truthy
      end
      it 'should return true if there is a tie' do
        board.active_board = ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'X', 'O']
        expect(board.game_finished?(players)).to be_truthy
      end
    end
    context 'there is not a winner' do
      it 'should return false' do
        board.active_board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        expect(board.game_finished?(players)).to eq(false)
        board.active_board = [' ', 'X', 'O', 'O', 'O', 'X', 'X', 'X', 'O']
        expect(board.game_finished?(players)).to eq(false)
      end
    end
  end

end
