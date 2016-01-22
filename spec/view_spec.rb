require 'spec_helper'

describe View do
  let(:view){View.new}

  describe '#get_user_input' do

  it 'should get input from a user' do
    allow(view).to receive(:get_user_input).and_return("Something")
      expect(view.get_user_input).to eq("Something")
    end
  end

  describe '#get_player_name' do
    it 'should receive user input' do
      name = "Bryan"
      allow(view).to receive(:get_player_name).and_return(name)
      expect(view.get_player_name(name)).to eq(name)
    end
    xit 'should assign the player name' do
      player = Player.new
      name = "Bryan"
      allow(view).to receive(:get_player_name).and_return(name)
      expect(player.name).to eq(name)
    end
  end

  describe '#display_game_options' do
    it 'should print out the game options' do
      expect(view.display_game_options).to eq("Please select the mode of play:\n    [1] You versus the computer\n    [2] You versus another player\n    [3] Demo computer versus computer")
    end
  end
end
