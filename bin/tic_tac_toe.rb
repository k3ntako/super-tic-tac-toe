#!/usr/bin/env ruby

require_relative '../lib/cli'
require_relative '../lib/user_interface'
require_relative '../lib/tic_tac_toe'
require_relative '../lib/game_configurator'
require_relative '../lib/game_generator'
require_relative '../lib/input_validator'
require_relative '../lib/game_configurator_message'

cli = CLI.new
ui = UserInterface.new(cli)
messenger = Messenger.new(user_interface: ui, message_generator: GameConfiguratorMessage.new)
game_configurator = GameConfigurator.new(
  user_interface: ui,
  input_validator: InputValidator.new,
  game_generator: GameGenerator.new,
  messenger: messenger
)

tic_tac_toe = TicTacToe.new(
  user_interface: ui,
  game_configurator: game_configurator,
)
tic_tac_toe.start
