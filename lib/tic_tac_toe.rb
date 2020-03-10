require_relative './cli'
require_relative './game_generator'

class TicTacToe
  def initialize(user_interface:, game_configurator:)
    @user_interface = user_interface
    @game_configurator = game_configurator
  end

  def start
    @user_interface.clear_output

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
    @game_configurator.create_a_game
  end
end
