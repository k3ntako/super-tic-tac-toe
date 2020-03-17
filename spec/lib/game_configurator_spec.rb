require_relative '../../lib/user_interface'
require_relative '../../lib/board'
require_relative '../../lib/game_configurator'
require_relative '../../lib/game_configurator_message'
require_relative './mock_classes/game_generator_mock'

RSpec.describe GameConfigurator do
  let(:mock_cli) { TestCLI.new }
  let(:ui) { UserInterface.new mock_cli }
  let(:mock_game_generator) { MockGameGenerator.new }
  let(:messenger) { Messenger.new(user_interface: ui, message_generator: GameConfiguratorMessage.new) }
  let(:game_configurator) do
    GameConfigurator.new(
      user_interface: ui,
      input_validator: InputValidator.new,
      game_generator: mock_game_generator,
      messenger: messenger
    )
  end

  describe 'create_a_game' do
    it 'should ask user if they would like to play a computer or a human' do
      mock_cli.fake_user_inputs = ['2', '1', '5']

      game_configurator.create_a_game

      expect(mock_cli.triggered_actions[3]).to eq 'get_user_input'
    end

    it 'should create a game with two human if user picks human as the opponent' do
      mock_cli.fake_user_inputs = ['1', '5']

      game_configurator.create_a_game

      action = mock_game_generator.triggered_actions[0]
      expect(action[:method]).to eq 'create_a_game'
      expect(action[:parameters][0][:strategy]).to eq nil
      expect(action[:parameters][0][:user_interface]).to eq ui
    end

    it 'should create a game with computer if user picks computer as the opponent' do
      mock_cli.fake_user_inputs = ['2', '1', '5']

      game_configurator.create_a_game

      action = mock_game_generator.triggered_actions[0]
      expect(action[:method]).to eq 'create_a_game'
      expect(action[:parameters][0][:strategy]).to be_truthy
      expect(action[:parameters][0][:user_interface]).to eq ui
    end

    it 'should keep asking for an opponent until the user inputs a valid response' do
      mock_cli.fake_user_inputs = ['10', 'akj', '!', '', '2', '2', '5'] # last two values are for difficulty and size

      game_configurator.create_a_game

      expect(mock_cli.displayed_messages[1]).to eq(
        "Would you like to play a human or a computer?\nEnter 1 for human, and 2 for computer:"
      )

      4.times do |i| # 4 is the number of invalid inputs
        base_idx = i * 3
        expect(mock_cli.displayed_messages[base_idx + 2]).to eq 'We got an invalid input, try again!'
        expect(mock_cli.displayed_messages[base_idx + 4]).to eq(
          "Would you like to play a human or a computer?\nEnter 1 for human, and 2 for computer:"
        )
      end

      action = mock_game_generator.triggered_actions[0]
      expect(action[:method]).to eq 'create_a_game'
      expect(action[:parameters][0][:strategy]).to be_truthy
      expect(action[:parameters][0][:user_interface]).to eq ui
    end

    it 'should create game with selected difficulty' do
      game_configurator = GameConfigurator.new(
        user_interface: ui,
        input_validator: InputValidator.new,
        game_generator: mock_game_generator,
        messenger: messenger
      )

      mock_cli.fake_user_inputs = ['2', '1', '5'] # opponent and difficulty selection
      game_configurator.create_a_game

      action = mock_game_generator.triggered_actions[0]
      expect(action[:method]).to eq 'create_a_game'
      expect(action[:parameters][0][:user_interface]).to eq ui
      expect(action[:parameters][0][:strategy]).to be_an_instance_of EasyStrategy
    end

    it 'should create game with selected difficulty' do
      game_configurator = GameConfigurator.new(
        user_interface: ui,
        input_validator: InputValidator.new,
        game_generator: mock_game_generator,
        messenger: messenger
      )

      mock_cli.fake_user_inputs = ['2', '2', '5'] # opponent and difficulty selection
      game_configurator.create_a_game

      action = mock_game_generator.triggered_actions[0]
      expect(action[:method]).to eq 'create_a_game'
      expect(action[:parameters][0][:user_interface]).to eq ui
      expect(action[:parameters][0][:strategy]).to be_an_instance_of MediumStrategy
    end

    it 'should create game with selected difficulty' do
      game_configurator = GameConfigurator.new(
        user_interface: ui,
        input_validator: InputValidator.new,
        game_generator: mock_game_generator,
        messenger: messenger
      )

      mock_cli.fake_user_inputs = ['2', '3', '5'] # opponent and difficulty selection
      game_configurator.create_a_game

      action = mock_game_generator.triggered_actions[0]
      expect(action[:method]).to eq 'create_a_game'
      expect(action[:parameters][0][:user_interface]).to eq ui
      expect(action[:parameters][0][:strategy]).to be_an_instance_of MinimaxStrategy
    end

    it 'should create game with selected width' do
      game_configurator = GameConfigurator.new(
        user_interface: ui,
        input_validator: InputValidator.new,
        game_generator: mock_game_generator,
        messenger: messenger
      )

      mock_cli.fake_user_inputs = ['2', '3', '5'] # opponent, difficulty, and size selections
      game_configurator.create_a_game

      action = mock_game_generator.triggered_actions[0]
      expect(action[:method]).to eq 'create_a_game'
      expect(action[:parameters][0][:user_interface]).to eq ui
      expect(action[:parameters][0][:strategy]).to be_an_instance_of MinimaxStrategy
      expect(action[:parameters][0][:width]).to eq 5
    end
  end
end
