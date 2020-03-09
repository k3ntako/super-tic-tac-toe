require 'cucumber/rspec/doubles'

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'
require_relative '../../lib/game_state'
require_relative '../../lib/game_messenger'

require_relative '../../spec/lib/mock_classes/cli_mock'

test_cli = nil

When(/^I am prompted to make a move$/) do
  allow_any_instance_of(GameState).to receive(:check_for_error).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(false, false, true)

  test_cli = TestCLI.new
  test_cli.fake_user_inputs = ['1', '2', '1'] # first input is for selecting human as opponent

  ui = UserInterface.new(test_cli)
  game_generator = GameGenerator.new
  tic_tac_toe = TicTacToe.new(
    user_interface: ui,
    game_generator: game_generator,
    input_validator: InputValidator.new
  )

  tic_tac_toe.start
end

Then(/^I should be able to enter an integer$/) do
  expect(test_cli.displayed_messages[6]).to eq 'Enter a number to make a move in the corresponding square (X\'s turn):'
  expect(test_cli.triggered_actions[12]).to eq 'get_user_input'
end

And(/^I should see who made the previous move$/) do
  expect(test_cli.displayed_messages[7]).to eq 'Previous Move: X on 2'
end

And(/^I should be able to see the updated board$/) do
  expect(test_cli.displayed_messages[8]).to eq 'nil,X,nil,nil,nil,nil,nil,nil,nil'
end

Then(/^the other player should be prompted to make a move$/) do
  expect(test_cli.displayed_messages[9]).to eq 'Enter a number to make a move in the corresponding square (O\'s turn):'
end

And(/^they should be able to enter an integer$/) do
  expect(test_cli.triggered_actions[18]).to eq 'get_user_input'
end

And(/^they should be able to see the updated board$/) do
  expect(test_cli.displayed_messages[11]).to eq 'O,X,nil,nil,nil,nil,nil,nil,nil'
end

When(/^the human player has made a move$/) do
  allow_any_instance_of(GameState).to receive(:check_for_error).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(false, false, true)

  test_cli = TestCLI.new
  test_cli.fake_user_inputs = ['2', '9'] # first input is for selecting computer as opponent

  ui = UserInterface.new(test_cli)
  game_generator = GameGenerator.new
  tic_tac_toe = TicTacToe.new(
    user_interface: ui,
    game_generator: game_generator,
    input_validator: InputValidator.new
  )

  tic_tac_toe.start
end

Then(/^I should see the board update with the computer move$/) do
  expect(test_cli.displayed_messages[11]).to include 'O'

  square_nine = test_cli.displayed_messages[11].split('').last
  expect(square_nine).to eq 'X' # user moved at 9, so it should not be overwritten by computer
end
