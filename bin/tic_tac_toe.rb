#!/usr/bin/env ruby

require_relative '../lib/cli'
require_relative '../lib/user_interface'
require_relative '../lib/tic_tac_toe'

cli = CLI.new
ui = UserInterface.new(cli)
game_generator = GameGenerator.new

tic_tac_toe = TicTacToe.new(user_interface: ui, game_generator: game_generator)
tic_tac_toe.start
