# frozen_string_literal: true

require_relative './cli'
require_relative './board'

# TicTacToe is the highest level class and handles the gameplay
class TicTacToe
  def initialize(user_interface)
    @user_interface = user_interface
    @board = Board.new
  end

  def start
    display_welcome
    display_board
  end

  def display_welcome
    welcome_message = 'Welcome to a game of Tic-Tac-Toe!'
    @user_interface.display_message welcome_message
  end

  def display_board
    @user_interface.display_board @board.board
  end
end
