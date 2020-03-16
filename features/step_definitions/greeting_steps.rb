require 'cucumber/rspec/doubles'

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'
require_relative '../../lib/game_state'
require_relative '../../lib/game_messenger'
require_relative '../../lib/user_interface'
require_relative '../../lib/game_generator'
require_relative '../../lib/game_configurator'
require_relative '../../lib/input_validator'
require_relative '../../lib/game_configurator'
require_relative '../../spec/lib/mock_classes/cli_mock'

test_cli = nil

When(/^I start the program$/) do
  allow_any_instance_of(GameMessenger).to receive(:clear_output).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(false, true)
  allow_any_instance_of(GameState).to receive(:player_move).and_return('1')

  test_cli = TestCLI.new

  allow(test_cli).to receive(:clear_output)
  test_cli.fake_user_inputs = ['1', '5', '6'] # opponent, board size, and position selections

  ui = UserInterface.new(test_cli)
  messenger = Messenger.new(user_interface: ui, message_generator: GameConfiguratorMessage.new)
  game_configurator = GameConfigurator.new(
    user_interface: ui,
    input_validator: InputValidator.new,
    game_generator: GameGenerator.new,
    messenger: messenger
  )
  tic_tac_toe = TicTacToe.new(
    user_interface: ui,
    game_configurator: game_configurator
  )

  tic_tac_toe.start
end

Then(/^I should see the welcome message$/) do
  expect(test_cli.displayed_messages[0]).to eq 'Welcome to a game of Tic-Tac-Toe!'
end
