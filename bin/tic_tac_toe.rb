#!/usr/bin/env ruby

require_relative "../lib/cli"
require_relative "../lib/tic_tac_toe"

cli = CLI.new

tic_tac_toe = TicTacToe.new(cli)
tic_tac_toe.print_welcome