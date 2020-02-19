#!/usr/bin/env ruby

require_relative '../lib/cli'
require_relative '../lib/tic_tac_toe'

cli = CLI.new
board = Board.new
player = Player.new

tic_tac_toe = TicTacToe.new(cli, board, player)
tic_tac_toe.start
