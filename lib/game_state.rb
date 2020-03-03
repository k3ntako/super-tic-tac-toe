class GameState
  attr_reader :board

  def initialize(game_messenger:, game_end_evaluator: nil, move_validator: nil, board: nil, players: nil)
    @game_messenger = game_messenger
    @game_end_evaluator = game_end_evaluator
    @move_validator = move_validator
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
      error_symbol = valid_move?(position)

      if error_symbol.nil?
        @board.update(current_player.mark, position)
        break
      end

      print_screen_for_move bottom_messages: [error_symbol]
    end
  end

  def print_screen_with_welcome
    print_screen_for_move top_message: :welcome
  end

  def print_screen_for_move(top_message: :title, bottom_messages: [])
    bottom_message_symbols = bottom_messages.push(instruction_symbol)
    print_screen top_message: top_message, bottom_messages: bottom_message_symbols
  end

  def print_screen(top_message: :title, bottom_messages: [])
    @game_messenger.display_messages top_message: top_message, board: @board, bottom_messages: bottom_messages
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

  def valid_move?(position)
    @move_validator.error_for_move(@board, position)
  end

  def current_player
    @players[@current_player_idx]
  end
end
