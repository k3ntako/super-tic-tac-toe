class GameState
  attr_reader :board

  def initialize(game_end_evaluator: nil, move_validator: nil, game_messenger: nil, board: nil, players: nil)
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

  def make_move
    position = nil

    loop do
      position = current_player.get_move

      is_valid_int, is_valid = validate_move(position)

      display_move_error(is_valid_int) unless is_valid

      break if is_valid
    end

    @board.update(current_player.mark, position)
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

  def validate_move(position)
    is_valid_int = @move_validator.valid_integer?(position)
    is_valid = is_valid_int && @move_validator.empty_square?(@board, position)

    [is_valid_int, is_valid]
  end

  def display_move_error(is_valid_int)
    return @game_messenger.display_not_valid_integer unless is_valid_int

    @game_messenger.display_square_unavaliable
  end

  def current_player
    @players[@current_player_idx]
  end
end
