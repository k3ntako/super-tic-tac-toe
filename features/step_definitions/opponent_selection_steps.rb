require 'cucumber/rspec/doubles'

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'
require_relative '../../lib/game_state'
require_relative '../../lib/game_messenger'

require_relative '../../spec/lib/mock_classes/cli_mock'

test_cli = nil

When(/^I am setting up the game$/) do
  allow_any_instance_of(InputValidator).to receive(:input_error).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(true) # ends game early

  test_cli = TestCLI.new
  test_cli.fake_user_inputs = ['1'] # selecting human as opponent

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

Then(/^I should be asked to choose a computer or human opponent$/) do
  expect(test_cli.displayed_messages[1]).to eq ''
  expect(test_cli.displayed_messages[2]).to eq(
    "Would you like to play a human or a computer?\nEnter 1 for human, and 2 for computer:"
  )
end
