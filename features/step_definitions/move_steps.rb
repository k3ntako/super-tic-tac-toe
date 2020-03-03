require 'cucumber/rspec/doubles'

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'
require_relative '../../lib/game_state'
require_relative '../../lib/game_messenger'

original_stdout = $stdout

When(/^I am prompted to make a move$/) do
  $stdout = StringIO.new

  allow_any_instance_of(GameMessenger).to receive(:clear_output).and_return(nil)

  cli = CLI.new
  tic_tac_toe = TicTacToe.new(cli)
  tic_tac_toe.start
end

Then(/^I should be able to enter an integer$/) do
  expect(GameMessenger).to receive(:clear_output).and_return(nil)


  stdout_ouput = $stdout.string.split("\n")
  expect(stdout_ouput[0]).to eq 'Welcome to a game of Tic-Tac-Toe!'

  $stdout = original_stdout
end
