class GameState
  attr_reader :board

  def initialize(game_end_evaluator: nil, user_input_validator: nil, game_messenger: nil, board: nil, players: nil)
    @game_messenger = game_messenger
    @game_end_evaluator = game_end_evaluator
    @user_input_validator = user_input_validator
    @board = board
    @players = players
    @current_player_idx = 0
  end

  def alternate_current_player
    @current_player_idx = @current_player_idx.zero? ? 1 : 0
  end

  def make_move
    position = current_player.get_move

    if !@user_input_validator.move_valid_integer? position
      @game_messenger.display_not_valid_integer
      make_move
    elsif !@user_input_validator.move_on_empty_square?(@board, position)
      @game_messenger.display_square_taken
      make_move
    else
      @board.update(current_player.mark, position)
    end
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

  def current_player
    @players[@current_player_idx]
  end
end
