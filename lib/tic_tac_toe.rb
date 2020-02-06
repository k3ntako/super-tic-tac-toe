# frozen_string_literal: true

require_relative './cli'

# TicTacToe is the highest level class and handles the gameplay
class TicTacToe
  def initialize(cli)
    @cli = cli
  end

  def print_welcome
    welcome_message = 'Welcome to a game of Tic-Tac-Toe!'
    @cli.put_string welcome_message
  end
end
