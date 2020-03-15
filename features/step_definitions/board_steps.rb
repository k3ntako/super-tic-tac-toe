require 'cucumber/rspec/doubles'

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'
require_relative '../../lib/game_state'
require_relative '../../lib/game_messenger'
require_relative '../../lib/game_configurator_message'

require_relative '../../spec/lib/mock_classes/cli_mock'

test_cli = nil

When(/^I start the game$/) do
  allow_any_instance_of(InputValidator).to receive(:input_error).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(false, true) # ends game early

  test_cli = TestCLI.new
  test_cli.fake_user_inputs = ['1', '1'] # opponent selection and position selection

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

Then(/^I should see the empty board$/) do
  expect(test_cli.displayed_messages[4]).to eq 'nil,nil,nil,nil,nil,nil,nil,nil,nil'
end

And(/^I should be prompted to make a move$/) do
  expect(test_cli.displayed_messages[5]).to eq 'Enter a number to make a move in the corresponding square (X\'s turn):'
end
