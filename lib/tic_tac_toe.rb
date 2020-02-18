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

    display_move_instruction

    position = get_move
    @board.make_move('X', position)

    display_board
  end

  def display_welcome
    welcome_message = 'Welcome to a game of Tic-Tac-Toe!'
    @user_interface.display_message welcome_message
  end

  def display_board
    @user_interface.display_board @board.state
  end

  def display_move_instruction
    instruction = "\nEnter a number to make a move in the corresponding square:"
    @user_interface.display_message instruction
  end

  def get_move
    @user_interface.get_user_input
  end
end
