class Game
  def initialize(args)
    @game_messenger = args[:game_messenger]
    @game_state = args[:game_state]
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
    @game_messenger.display_move_instruction

    @game_state.make_move

    @game_messenger.display_board @game_state.board
  end

  def exit_game
    winner = @game_state.winner

    if winner.nil?
      @game_messenger.display_game_over_with_tie
    else
      @game_messenger.display_game_over_with_winner winner
    end
  end
end
