# frozen_string_literal: true

require_relative './cli'
require_relative './board'

# TicTacToe is the highest level class and handles the gameplay
class TicTacToe
  def initialize(cli)
    @cli = cli
    @board = Board.new
  end

  def start
    print_welcome
    print_board
  end

  def print_welcome
    welcome_message = 'Welcome to a game of Tic-Tac-Toe!'
    @cli.put_string welcome_message
  end

  def print_board
    board_str = @board.to_s
    @cli.put_string board_str
  end
end
