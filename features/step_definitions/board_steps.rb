require 'cucumber/rspec/doubles'

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'
require_relative '../../lib/game_state'
require_relative '../../lib/game_messenger'

original_stdout = $stdout

When(/^the game starts$/) do
  $stdout = StringIO.new

  allow_any_instance_of(GameMessenger).to receive(:clear_output).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(true)

  cli = CLI.new
  tic_tac_toe = TicTacToe.new(cli)
  tic_tac_toe.start
end

Then(/^I should see the empty board$/) do
  stdout_ouput = $stdout.string.split("\n")
  expect(stdout_ouput[2]).to eq ' 1 | 2 | 3 '
  expect(stdout_ouput[3]).to eq '-----------'
  expect(stdout_ouput[4]).to eq ' 4 | 5 | 6 '
  expect(stdout_ouput[5]).to eq '-----------'
  expect(stdout_ouput[6]).to eq ' 7 | 8 | 9 '
end

Then(/^I should be prompted to make a move$/) do
  stdout_ouput = $stdout.string.split("\n")
  expect(stdout_ouput[8]).to eq 'Enter a number to make a move in the corresponding square (X\'s turn):'

  $stdout = original_stdout
end
