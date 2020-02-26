require_relative '../../lib/player'
require_relative '../../lib/game_messenger'

RSpec.describe GameMessenger do
  let(:cli) { CLI.new }
  let(:user_interface) { UserInterface.new(cli) }
  let(:game_messenger) { GameMessenger.new(user_interface) }
  let(:player) { Player.new(user_interface, 'X') }

  describe 'display_move_instruction' do
    it 'should display message telling the user know the game is over and who won' do
      expected_message = 'Enter a number to make a move in the corresponding square:'
      expect(user_interface).to receive(:display_message).with expected_message

      game_messenger.display_move_instruction
    end
  end

  describe 'display_game_over_with_winner' do
    it 'should display message telling the user know the game is over and who won' do
      expected_message = 'Game Over: X Wins'
      expect(user_interface).to receive(:display_message).with expected_message

      game_messenger.display_game_over_with_winner player
    end
  end

  describe 'display_game_over_with_tie' do
    it 'should display message telling the user know the game is over and who won' do
      expected_message = 'Game Over: Tie!'
      expect(user_interface).to receive(:display_message).with expected_message

      game_messenger.display_game_over_with_tie
    end
  end
end
