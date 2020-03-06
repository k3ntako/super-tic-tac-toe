class GameState
  attr_reader :board

  def initialize(game_messenger:, game_end_evaluator:, input_validator:, board:, players:)
    @game_messenger = game_messenger
    @game_end_evaluator = game_end_evaluator
    @input_validator = input_validator
    @board = board
    @players = players
    @current_player_idx = 0
  end

  def alternate_current_player
    @current_player_idx = @current_player_idx.zero? ? 1 : 0
  end

  def player_move
    loop do
      position = current_player.get_move
      error = check_for_error(position)

      if error.nil?
        @board.update(current_player.mark, position)
        break
      end

      display_board_with_messages_for_move bottom_messages: [error]
    end
  end

  def display_board_with_messages_with_welcome
    display_board_with_messages_for_move top_message: :welcome
  end

  def display_board_with_messages_for_move(top_message: :title, bottom_messages: [])
    bottom_message_symbols = bottom_messages.push(instruction_symbol)
    display_board_with_messages top_message: top_message, bottom_messages: bottom_message_symbols
  end

  def display_board_with_messages(top_message: :title, bottom_messages: [])
    @game_messenger.display_board_with_messages(
      top_message: top_message,
      board: @board,
      bottom_messages: bottom_messages
    )
  end

  def game_over?
    @game_end_evaluator.game_over?(@board)
  end

  def player_won?
    @game_end_evaluator.player_won?(@board)
  end

  def previous_player
    previous_player_idx = @current_player_idx.zero? ? 1 : 0
    @players[previous_player_idx]
  end

  private

  def instruction_symbol
    @current_player_idx.zero? ? :move_instruction_x : :move_instruction_o
  end

  def check_for_error(position)
    @input_validator.move_error(@board, position)
  end

  def current_player
    @players[@current_player_idx]
  end
end
