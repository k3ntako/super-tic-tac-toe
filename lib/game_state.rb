class GameState
  attr_reader :board

  def initialize(args)
    @game_end_evaluator = args[:game_end_evaluator]
    @board = args[:board]
    @players = args[:players]
    @current_player_idx = 0
  end

  def alternate_current_player
    @current_player_idx = @current_player_idx.zero? ? 1 : 0
  end

  def make_move
    position = current_player.get_move
    @board.update(current_player.mark, position)
  end

  def game_over?
    @game_end_evaluator.game_over?(@board)
  end

  def winner
    did_player_win = @game_end_evaluator.player_won?(@board)
    return previous_player if did_player_win

    nil
  end

  private

  def current_player
    @players[@current_player_idx]
  end

  def previous_player
    previous_player_idx = @current_player_idx.zero? ? 1 : 0
    @players[previous_player_idx]
  end
end
