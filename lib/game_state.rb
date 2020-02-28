class GameState
  attr_reader :board

  def initialize(game_end_evaluator: nil, move_validator: nil, board: nil, players: nil)
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
    loop do
      position = current_player.get_move

      if valid_move?(position)
        @board.update(current_player.mark, position)
        break
      end
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

  def valid_move?(position)
    @move_validator.move_valid?(@board, position)
  end

  def current_player
    @players[@current_player_idx]
  end
end
