class Game
  def initialize(args)
    @user_interface = args[:user_interface]
    @board = args[:board]
    @game_end_evaluator = args[:game_end_evaluator]
    @current_player = args[:player_one]
    @previous_player = args[:player_two]
  end

  def start
    display_board

    until @game_end_evaluator.game_over?(@board)
      one_turn

      alternate_current_player
    end

    exit_game
  end

  private

  def one_turn
    display_move_instruction

    prompt_move

    display_board
  end

  def prompt_move
    position = @current_player.get_move
    @current_player.make_move(@board, position)
  end

  def display_board
    @user_interface.display_board @board.state
  end

  def display_move_instruction
    instruction = 'Enter a number to make a move in the corresponding square:'
    @user_interface.display_message instruction
  end

  def alternate_current_player
    @current_player, @previous_player = @previous_player, @current_player
  end

  def exit_game
    did_player_win = @game_end_evaluator.player_won?(@board)

    if did_player_win
      display_game_over_with_winner @previous_player
    else
      display_game_over_with_tie
    end
  end

  def display_game_over_with_winner(winner)
    message = "Game Over: #{winner.mark} Wins"
    @user_interface.display_message message
  end

  def display_game_over_with_tie
    message = 'Game Over: Tie!'
    @user_interface.display_message message
  end
end
