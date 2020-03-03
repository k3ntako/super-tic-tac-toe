class Game
  def initialize(game_messenger: nil, game_state: nil)
    @game_messenger = game_messenger
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
    did_player_win = @game_state.player_won?

    if did_player_win
      winner = @game_state.previous_player
      @game_state.display_board_with_messages bottom_messages: [:game_over_X_wins] if winner.mark == 'X'
      @game_state.display_board_with_messages bottom_messages: [:game_over_O_wins] if winner.mark == 'O'
    else
      @game_state.display_board_with_messages bottom_messages: [:game_over_with_tie]
    end
  end
end
