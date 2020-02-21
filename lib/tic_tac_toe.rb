require_relative './cli'
require_relative './board'
require_relative './player'
require_relative './game_generator'

class TicTacToe
  def initialize(user_interface)
    @user_interface = user_interface
  end

  def start
    display_welcome

    game = create_a_game
    game.start
  end

  private

  def display_welcome
    welcome_message = 'Welcome to a game of Tic-Tac-Toe!'
    @user_interface.display_message welcome_message
  end

  def create_a_game
    game_generator = GameGenerator.new
    game_generator.create_a_game @user_interface
  end
end
