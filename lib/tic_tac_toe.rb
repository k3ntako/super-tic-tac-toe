require_relative './cli'
require_relative './game_generator'

class TicTacToe
  def initialize(user_interface:, game_generator:, input_validator:)
    @user_interface = user_interface
    @game_generator = game_generator
    @input_validator = input_validator
  end

  def start
    @user_interface.clear_output

    display_welcome
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
    loop do
      ask_for_opponent_selection

      selection = @user_interface.get_user_input
      error = @input_validator.input_error selection

      selection_int = error.nil? && Integer(selection)

      return :human if selection_int == 1
      return :computer if selection_int == 2

      @user_interface.clear_output
      @user_interface.display_message 'We got an invalid input, try again!'
    end
  end

  def create_a_game(opponent:)
    @game_generator.create_a_game(user_interface: @user_interface, opponent: opponent)
  end
end
