class Game
  def initialize(args)
    @game_messenger = args[:game_messenger]
    @game_end_evaluator = args[:game_end_evaluator]
    @game_state = args[:game_state]
  end

  def start
    @game_messenger.display_board @game_state.board

    until @game_end_evaluator.game_over?(@game_state.board)
      one_turn

      @game_state.alternate_current_player
    end

    exit_game
  end

  private

  def one_turn
    @game_messenger.display_move_instruction

    @game_state.make_move

    @game_messenger.display_board @game_state.board
  end

  def exit_game
    did_player_win = @game_end_evaluator.player_won?(@game_state.board)

    if did_player_win
      @game_messenger.display_game_over_with_winner @game_state.previous_player
    else
      @game_messenger.display_game_over_with_tie
    end
  end
end
