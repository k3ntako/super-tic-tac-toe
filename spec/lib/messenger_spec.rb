require_relative '../../lib/human_player'
require_relative '../../lib/messenger'
require_relative '../../lib/game_message'

RSpec.describe Messenger do
  let(:board) { Board.new }
  let(:test_cli) { TestCLI.new }
  let(:ui) { UserInterface.new(test_cli) }
  let(:game_message) { GameMessage.new }
  let(:game_messenger) do
    GameMessenger.new(
      user_interface: ui,
      message_generator: game_message
    )
  end
  let(:player) { HumanPlayer.new(user_interface, 'X', InputValidator.new) }

  describe 'display' do
    it 'should display the associated message given a symbol' do
      game_messenger.display message: :welcome
      game_messenger.display message: :not_valid_integer

      displayed_messages = test_cli.displayed_messages

      expect(displayed_messages[0]).to eq('Welcome to a game of Tic-Tac-Toe!')
      expect(displayed_messages[1]).to eq('Make sure it\'s an integer and try again!')
    end
  end

  describe 'display_empty_line' do
    it 'should display an empty line' do
      game_messenger.display_empty_line

      expect(test_cli.triggered_actions[0]).to eq('display_empty_line')
    end
  end

  describe 'clear_output' do
    it 'should clear output' do
      game_messenger.clear_output

      expect(test_cli.triggered_actions[0]).to eq('clear_output')
    end
  end

  describe 'display' do
    it 'should display the associated message given a symbol' do
      game_messenger.display message: :welcome
      game_messenger.display message: :not_valid_integer

      displayed_messages = test_cli.displayed_messages

      expect(displayed_messages[0]).to eq('Welcome to a game of Tic-Tac-Toe!')
      expect(displayed_messages[1]).to eq('Make sure it\'s an integer and try again!')
    end
  end
end
