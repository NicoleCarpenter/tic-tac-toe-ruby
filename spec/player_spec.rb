require 'spec_helper'

describe Player do
  let(:player){Player.new}

  describe '#is_human?' do
    context 'player is human' do
      player = Player.new("Marci")
      it 'should be truthy' do
        expect(player.is_human?(player)).to be_truthy
      end
    end
    context 'player is a computer' do
      it 'should return false' do
        expect(player.is_human?(Player.new("Computer"))).to eq(false)
        expect(player.is_human?(Player.new("Computer 1"))).to eq(false)
        expect(player.is_human?(Player.new("Computer 1"))).to eq(false)
      end
    end
  end

  describe '#player_move' do
    player = Player.new("Jen", "X")
    board = Board.new(9)
    view = View.new
    board.active_board = ['X', 'X', 'X', ' ', ' ', ' ', ' ', ' ', ' ']
    context 'invalid move' do
      move = 3
      xit 'should prompt the user for another move' do
        expect(player.player_move(player, board, view)).to
      end
    end
  end

  describe '#identify_computer_players' do
    players = [Player.new("Leon"), Player.new("Computer"), Player.new("Computer 1")]
    it 'should return computer players' do
      expect(player.identify_computer_players(players)).to include(players[1], players[2])
    end
  end

  describe '#player_board' do
    it 'should return an array of the index positions where the player has moved' do
      player = Player.new("Patrick", "X")
      board = ['X', ' ', 'O', 'O', 'O', 'X', 'X', 'X', 'O']
      expect(player.player_board(board)).to eq([0, 5, 6, 7])
    end
  end

  describe '#computer_move' do
    xit
  end

  describe '#select_move_type' do
    players = [Player.new("Cassie"), Player.new("Computer")]
    view = View.new
    board = Board.new(9)
    context 'player is a person' do
      xit 'should call the player_move method' do
        player = players[0]
        expect(player.select_move_type(players, player, view, board)).to receive(player_move).with(player, board, view)
      end
    end

    context 'player is a computer' do
      xit 'should call the player_move method' do
        player = players[1]
        expect(player.select_move_type(players, player, view, board)).to receive(computer_move).with(player, board, view)
      end
    end
  end
end
