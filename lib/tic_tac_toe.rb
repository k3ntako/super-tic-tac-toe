require_relative './cli'
require_relative './game_generator'

class TicTacToe
  def initialize(user_interface:, game_generator:)
    @user_interface = user_interface
    @game_generator = game_generator
  end

  def start
    @user_interface.clear_output

    display_welcome
    ask_for_opponent_selection
    opponent = get_opponent_selection

    game = create_a_game(opponent: opponent)
    game.start
  end

  private

  def display_welcome
    welcome_message = 'Welcome to a game of Tic-Tac-Toe!'
    @user_interface.display_message welcome_message
  end

  def ask_for_opponent_selection
    @user_interface.display_empty_line
    @user_interface.display_message 'Would you like to play a human or a computer?'
    @user_interface.display_message 'Enter 1 for human, and 2 for computer:'
  end

  def get_opponent_selection
    selection = @user_interface.get_user_input

    return :human if selection.to_i == 1
    return :computer if selection.to_i == 2
  end

  def create_a_game(opponent:)
    @game_generator.create_a_game(user_interface: @user_interface, opponent: opponent)
  end
end
