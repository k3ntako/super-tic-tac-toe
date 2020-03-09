require 'cucumber/rspec/doubles'

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'
require_relative '../../lib/game_state'
require_relative '../../lib/game_messenger'
require_relative '../../lib/user_interface'
require_relative '../../lib/game_generator'

original_stdout = $stdout
stdout_ouput = []

When(/^I start the program$/) do
  $stdout = StringIO.new

  allow_any_instance_of(GameMessenger).to receive(:clear_output).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(true)

  cli = CLI.new

  allow(cli).to receive(:clear_output)

  ui = UserInterface.new(cli)
  game_generator = GameGenerator.new
  tic_tac_toe = TicTacToe.new(
    user_interface: ui,
    game_generator: game_generator,
    input_validator: InputValidator.new
  )

  allow(cli).to receive(:get_user_input).and_return('1')

  tic_tac_toe.start

  stdout_ouput = $stdout.string.split("\n")
end

Then(/^I should see the welcome message$/) do
  expect(stdout_ouput[0]).to eq 'Welcome to a game of Tic-Tac-Toe!'
end

And(/^I should be asked to choose a computer or human opponent$/) do
  expect(stdout_ouput[1]).to eq ''
  expect(stdout_ouput[2]).to eq 'Would you like to play a human or a computer?'
  expect(stdout_ouput[3]).to eq 'Enter 1 for human, and 2 for computer:'
end

And(/^I should see the empty board$/) do
  expect(stdout_ouput[6]).to eq ' 1 | 2 | 3 '
  expect(stdout_ouput[7]).to eq '-----------'
  expect(stdout_ouput[8]).to eq ' 4 | 5 | 6 '
  expect(stdout_ouput[9]).to eq '-----------'
  expect(stdout_ouput[10]).to eq ' 7 | 8 | 9 '
end

And(/^I should be prompted to make a move$/) do
  stdout_ouput = $stdout.string.split("\n")
  expect(stdout_ouput[12]).to eq 'Enter a number to make a move in the corresponding square (X\'s turn):'

  $stdout = original_stdout
end
