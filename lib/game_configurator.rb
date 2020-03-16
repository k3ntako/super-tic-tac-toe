require_relative './easy_strategy'
require_relative './medium_strategy'
require_relative './minimax_strategy'

class GameConfigurator
  def initialize(user_interface:, input_validator:, game_generator:, messenger:)
    @user_interface = user_interface
    @input_validator = input_validator
    @game_generator = game_generator
    @messenger = messenger
  end

  def create_a_game
    opponent = get_selection(message: :ask_for_opponent_selection, resolve: resolve_opponent)

    strategy = get_selection(message: :ask_for_difficulty, resolve: resolve_strategy) if opponent == :computer

    width = get_selection(message: :ask_for_board_width, resolve: resolve_width)

    game_generator.create_a_game(user_interface: user_interface, strategy: strategy, width: width)
  end

  private

  attr_reader :user_interface, :input_validator, :game_generator, :messenger

  def get_selection(message:, resolve:)
    loop do
      begin
        selection = prompt(message: message)
        selected_output = resolve.call(Integer(selection))

        return selected_output unless selected_output.nil?
      rescue IntegerError # rubocop:disable Lint/SuppressedException
      end

      display_try_again
    end
  end

  def prompt(message:)
    messenger.display_empty_line
    messenger.display(message: message)

    get_user_input
  end

  def display_try_again
    messenger.clear_output
    messenger.display(message: :try_again)
  end

  def get_user_input
    selection = user_interface.get_user_input
    input_validator.input_error selection

    selection
  end

  def resolve_opponent
    proc do |selection|
      output = :human if selection == 1
      output = :computer if selection == 2

      output
    end
  end

  def resolve_strategy
    proc do |selection|
      output = EasyStrategy.new if selection == 1
      output = MediumStrategy.new if selection == 2
      output = MinimaxStrategy.new(game_end_evaluator: GameEndEvaluator.new) if selection == 3

      output
    end
  end

  def resolve_width
    proc do |selection|
      output = selection if selection.between?(3, 12) # inclusive

      output
    end
  end
end
