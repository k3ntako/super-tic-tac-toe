class Game
  def initialize(game_state:)
    @game_state = game_state
  end

  def start
    @game_state.display_board_with_messages_with_welcome

    one_turn until @game_state.game_over?

    exit_game
  end

  private

  def one_turn
    @game_state.player_move

    @game_state.alternate_current_player

    @game_state.display_board_with_messages_for_move
  end

  def exit_game
    winner_mark = @game_state.player_won? ? @game_state.previous_player.mark : nil

    @game_state.display_board_with_messages bottom_messages: [[
      :game_over,
      { winner: winner_mark }
    ]]
  end
end
