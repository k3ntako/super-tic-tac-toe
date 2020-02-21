require_relative './cli'
require_relative './board'
require_relative './player'

class TicTacToe
  def initialize(user_interface)
    @user_interface = user_interface
  end

  def start
    display_welcome
  end

  private

  def display_welcome
    welcome_message = 'Welcome to a game of Tic-Tac-Toe!'
    @user_interface.display_message welcome_message
  end
end
