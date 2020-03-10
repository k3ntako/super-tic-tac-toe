class GameConfigurator
  def initialize(user_interface:, input_validator:, game_generator:, messenger:)
    @user_interface = user_interface
    @input_validator = input_validator
    @game_generator = game_generator
    @messenger = messenger
  end

  def create_a_game
    opponent = get_opponent_selection
    game_generator.create_a_game(user_interface: user_interface, opponent: opponent)
  end

  private

  attr_reader :user_interface, :input_validator, :game_generator, :messenger

  def ask_for_opponent_selection
    messenger.display_empty_line
    messenger.display(message: :ask_for_opponent_selection)
  end

  def get_opponent_selection
    loop do
      ask_for_opponent_selection

      selection = user_interface.get_user_input
      error = input_validator.input_error selection

      selection_int = error.nil? && Integer(selection)

      return :human if selection_int == 1
      return :computer if selection_int == 2

      messenger.clear_output
      messenger.display(message: :try_again)
    end
  end
end
