class Game
  def initialize(args)
    @game_messenger = args[:game_messenger]
    @board = args[:board]
    @game_end_evaluator = args[:game_end_evaluator]
    @current_player = args[:player_one]
    @previous_player = args[:player_two]
  end

  def start
    @game_messenger.display_board @board

    until @game_end_evaluator.game_over?(@board)
      one_turn

      alternate_current_player
    end

    exit_game
  end

  private

  def one_turn
    @game_messenger.display_move_instruction

    prompt_move

    @game_messenger.display_board @board
  end

  def prompt_move
    position = @current_player.get_move
    @current_player.make_move(@board, position)
  end

  def alternate_current_player
    @current_player, @previous_player = @previous_player, @current_player
  end

  def exit_game
    did_player_win = @game_end_evaluator.player_won?(@board)

    if did_player_win
      @game_messenger.display_game_over_with_winner @previous_player
    else
      @game_messenger.display_game_over_with_tie
    end
  end
end
