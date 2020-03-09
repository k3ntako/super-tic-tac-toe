#!/usr/bin/env ruby

require_relative '../lib/cli'
require_relative '../lib/user_interface'
require_relative '../lib/tic_tac_toe'
require_relative '../lib/input_validator'

cli = CLI.new
ui = UserInterface.new(cli)
game_generator = GameGenerator.new
input_validator = InputValidator.new

tic_tac_toe = TicTacToe.new(
  user_interface: ui,
  game_generator: game_generator,
  input_validator: input_validator
)
tic_tac_toe.start
