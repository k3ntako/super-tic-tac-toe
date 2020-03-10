class GameConfigurator
  def initialize(user_interface:, input_validator:, game_generator:)
    @user_interface = user_interface
    @input_validator = input_validator
    @game_generator = game_generator
  end

  def create_a_game
    opponent = get_opponent_selection
    @game_generator.create_a_game(user_interface: user_interface, opponent: opponent)
  end

  private

  attr_reader :user_interface, :input_validator

  def ask_for_opponent_selection
    user_interface.display_empty_line
    user_interface.display_message 'Would you like to play a human or a computer?'
    user_interface.display_message 'Enter 1 for human, and 2 for computer:'
  end

  def get_opponent_selection
    loop do
      ask_for_opponent_selection

      selection = user_interface.get_user_input
      error = input_validator.input_error selection

      selection_int = error.nil? && Integer(selection)

      return :human if selection_int == 1
      return :computer if selection_int == 2

      user_interface.clear_output
      user_interface.display_message 'We got an invalid input, try again!'
    end
  end
end
