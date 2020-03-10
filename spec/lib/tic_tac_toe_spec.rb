require_relative '../../lib/user_interface'
require_relative '../../lib/board'
require_relative '../../lib/tic_tac_toe'
require_relative './mock_classes/game_configurator_mock'
require_relative './mock_classes/game_mock'

RSpec.describe TicTacToe do
  let(:mock_cli) { TestCLI.new }
  let(:ui) { UserInterface.new mock_cli }
  let(:mock_game_configurator) do
    MockGameConfigurator.new(
      user_interface: ui,
      input_validator: nil,
      game_generator: nil,
      messenger: nil
    )
  end
  let(:tic_tac_toe) do
    TicTacToe.new(
      user_interface: ui,
      game_configurator: mock_game_configurator
    )
  end

  describe 'start' do
    it 'should clear output' do
      tic_tac_toe.start

      expect(mock_cli.triggered_actions[0]).to eq 'clear_output'
    end

    it 'should display welcome' do
      tic_tac_toe.start

      expect(mock_cli.displayed_messages[0]).to eq 'Welcome to a game of Tic-Tac-Toe!'
    end

    it 'should create new game' do
      tic_tac_toe.start

      expect(mock_game_configurator.triggered_actions[0]).to eq('create_a_game')
    end

    it 'should play game' do
      tic_tac_toe.start

      game = mock_game_configurator.last_game_created
      expect(game.triggered_actions[0]).to eq('start')
    end
  end
end
