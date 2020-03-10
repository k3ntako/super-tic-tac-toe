require_relative '../../lib/user_interface'
require_relative '../../lib/board'
require_relative '../../lib/game_configurator'
require_relative '../../lib/game_configurator_message'
require_relative './mock_classes/game_generator_mock'

RSpec.describe GameConfigurator do
  let(:mock_cli) { TestCLI.new }
  let(:ui) { UserInterface.new mock_cli }
  let(:mock_game_generator) { MockGameGenerator.new }
  let(:game_configurator) do
    messenger = Messenger.new(user_interface: ui, message_generator: GameConfiguratorMessage.new)
    GameConfigurator.new(
      user_interface: ui,
      input_validator: InputValidator.new,
      game_generator: mock_game_generator,
      messenger: messenger
    )
  end

  describe 'create_a_game' do
    it 'should ask user if they would like to play a computer or a human' do
      mock_cli.fake_user_inputs = ['2']

      game_configurator.create_a_game

      expect(mock_cli.triggered_actions[3]).to eq 'get_user_input'
    end

    it 'should create a game with two human if user picks human as the opponent' do
      mock_cli.fake_user_inputs = ['1']

      game_configurator.create_a_game

      expect(mock_game_generator.triggered_actions[0]).to eq 'create_a_game'
      mock_game = mock_game_generator.last_game_created

      expect(mock_game.players).to eq %i[human human]
    end

    it 'should create a game with computer if user picks computer as the opponent' do
      mock_cli.fake_user_inputs = ['2']

      game_configurator.create_a_game

      expect(mock_game_generator.triggered_actions[0]).to eq 'create_a_game'
      mock_game = mock_game_generator.last_game_created

      expect(mock_game.players).to eq %i[human computer]
    end

    it 'should keep asking for an opponent until the user inputs a valid response' do
      mock_cli.fake_user_inputs = ['10', 'akj', '!', '', '2']

      game_configurator.create_a_game

      expect(mock_cli.displayed_messages[1]).to eq(
        "Would you like to play a human or a computer?\nEnter 1 for human, and 2 for computer:"
      )
      # prints the same message for every invalid input (in other words, all but the last input)
      (mock_cli.fake_user_inputs.length - 1).times do |i|
        base_idx = i * 3
        expect(mock_cli.displayed_messages[base_idx + 2]).to eq 'We got an invalid input, try again!'
        expect(mock_cli.displayed_messages[base_idx + 4]).to eq(
          "Would you like to play a human or a computer?\nEnter 1 for human, and 2 for computer:"
        )
      end

      mock_game = mock_game_generator.last_game_created

      expect(mock_game.players).to eq %i[human computer]
    end
  end
end
