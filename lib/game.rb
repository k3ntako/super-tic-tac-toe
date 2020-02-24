require_relative './game_end_evaluator'

class Game
  def initialize(user_interface, board, player_one, player_two)
    @user_interface = user_interface
    @board = board
    @current_player = player_one
    @previous_player = player_two
  end

  def start
    display_board

    until game_over?
      one_turn

      alertnate_current_player
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

  def alertnate_current_player
    @current_player, @previous_player = @previous_player, @current_player
  end

  def game_over?
    game_end_evaluator = GameEndEvaluator.new

    did_player_win = game_end_evaluator.player_won?(@board)

    did_player_win || !game_end_evaluator.any_remaining_moves?(@board)
  end

  def exit_game
    game_end_evaluator = GameEndEvaluator.new

    did_player_win = game_end_evaluator.player_won?(@board)

    if did_player_win
      exit_game_with_winner @previous_player
    else
      exit_game_with_tie
    end
  end

  def exit_game_with_winner(winner)
    message = "Game Over: #{winner.mark} Wins"
    @user_interface.display_message message
  end

  def exit_game_with_tie
    message = 'Game Over: Tie!'
    @user_interface.display_message message
  end
end
