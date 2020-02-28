class Game
  def initialize(game_messenger: nil, game_state: nil)
    @game_messenger = game_messenger
    @game_state = game_state
  end

  def start
    @game_messenger.display_board @game_state.board

    until @game_state.game_over?
      one_turn

      @game_state.alternate_current_player
    end

    exit_game
  end

  private

  def one_turn
    @game_messenger.display message: :move_instruction

    @game_state.make_move

    @game_messenger.display_board @game_state.board
  end

  def exit_game
    did_player_win = @game_state.player_won?

    if did_player_win
      winner = @game_state.previous_player
      @game_messenger.display message: :game_over_X_wins if winner.mark == 'X'
      @game_messenger.display message: :game_over_O_wins if winner.mark == 'O'
    else
      @game_messenger.display(message: :game_over_with_tie)
    end
  end
end
