require 'cucumber/rspec/doubles'

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'
require_relative '../../lib/game_state'
require_relative '../../lib/game_messenger'

require_relative '../../spec/lib/mock_classes/cli_mock'

test_cli = nil

When(/^I am prompted to make a move$/) do
  allow_any_instance_of(GameState).to receive(:check_for_error).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(false, true)

  test_cli = TestCLI.new
  test_cli.fake_user_inputs = ['1', '2']

  ui = UserInterface.new(test_cli)
  game_generator = GameGenerator.new
  tic_tac_toe = TicTacToe.new(user_interface: ui, game_generator: game_generator)

  tic_tac_toe.start
end

Then(/^I should be able to enter an integer$/) do
  expect(test_cli.displayed_messages[5]).to eq 'Enter a number to make a move in the corresponding square (X\'s turn):'
  expect(test_cli.triggered_actions[11]).to eq 'get_user_input'
end

And(/^I should be able to see the updated board$/) do
  expect(test_cli.displayed_messages[7]).to eq 'nil,X,nil,nil,nil,nil,nil,nil,nil'
end
