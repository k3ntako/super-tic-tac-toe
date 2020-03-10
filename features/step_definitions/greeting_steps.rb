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

original_stdout = $stdout
stdout_ouput = []

When(/^I start the program$/) do
  $stdout = StringIO.new

  allow_any_instance_of(GameMessenger).to receive(:clear_output).and_return(nil)
  allow_any_instance_of(GameState).to receive(:game_over?).and_return(false, true)
  allow_any_instance_of(GameState).to receive(:player_move).and_return('1')

  cli = CLI.new

  allow(cli).to receive(:clear_output)

  ui = UserInterface.new(cli)
  game_configurator = GameConfigurator.new(
    user_interface: ui,
    input_validator: InputValidator.new,
    game_generator: GameGenerator.new
  )
  tic_tac_toe = TicTacToe.new(
    user_interface: ui,
    game_configurator: game_configurator
  )

  allow(cli).to receive(:get_user_input).and_return('1') # select opponent

  tic_tac_toe.start

  stdout_ouput = $stdout.string.split("\n")
end

Then(/^I should see the welcome message$/) do
  expect(stdout_ouput[0]).to eq 'Welcome to a game of Tic-Tac-Toe!'

  $stdout = original_stdout
end
