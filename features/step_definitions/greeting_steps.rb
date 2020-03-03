require 'cucumber/rspec/doubles'

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'
require_relative '../../lib/game_state'
require_relative '../../lib/game_messenger'

When(/^I start the game$/) do
  $stdout = StringIO.new

  allow_any_instance_of(GameMessenger).to receive(:clear_output).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(true)

  cli = CLI.new
  tic_tac_toe = TicTacToe.new(cli)
  tic_tac_toe.start
end

Then(/^I should see the welcome message$/) do
  stdout_ouput = $stdout.string.split("\n")
  expect(stdout_ouput[0]).to eq 'Welcome to a game of Tic-Tac-Toe!'
end