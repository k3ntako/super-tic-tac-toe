class GameState
  attr_reader :board

  def initialize(args)
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

  def previous_player
    previous_player_idx = @current_player_idx.zero? ? 1 : 0
    @players[previous_player_idx]
  end

  private

  def current_player
    @players[@current_player_idx]
  end
end
