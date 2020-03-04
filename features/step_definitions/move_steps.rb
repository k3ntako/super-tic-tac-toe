require 'cucumber/rspec/doubles'

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'
require_relative '../../lib/game_state'
require_relative '../../lib/game_messenger'

require_relative '../../spec/lib/mock_classes/cli_mock'

original_stdout = $stdout
test_cli = nil

When(/^I am prompted to make a move$/) do
  allow_any_instance_of(GameState).to receive(:check_for_error).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(false, true)

  test_cli = TestCLI.new
  test_cli.fake_user_inputs = ['2']

  tic_tac_toe = TicTacToe.new(test_cli)

  tic_tac_toe.start
end

Then(/^I should be able to enter an integer$/) do
  expect(test_cli.displayed_messages[2]).to eq 'Enter a number to make a move in the corresponding square (X\'s turn):'
  expect(test_cli.triggered_actions[5]).to eq 'get_user_input'
end

Then(/^I should be able to see the updated board$/) do
  p test_cli.displayed_messages

  expect(test_cli.displayed_messages[4]).to eq 'nil,X,nil,nil,nil,nil,nil,nil,nil'
end
