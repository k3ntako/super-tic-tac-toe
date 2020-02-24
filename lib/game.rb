require_relative './game_end_evaluator'

class Game
  def initialize(user_interface, board, player_one, player_two)
    @user_interface = user_interface
    @board = board
    @active_player_index = 0
    @players = [player_one, player_two]
  end

  def start
    display_board

    until game_over?
      one_turn

      alertnate_active_player
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
    position = active_player.get_move
    active_player.make_move(@board, position)
  end

  def display_board
    @user_interface.display_board @board.state
  end

  def display_move_instruction
    instruction = 'Enter a number to make a move in the corresponding square:'
    @user_interface.display_message instruction
  end

  def active_player
    @players[@active_player_index]
  end

  def alertnate_active_player
    @active_player_index = @active_player_index.zero? ? 1 : 0
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
      winner_index = @active_player_index.zero? ? 1 : 0
      winner = @players[winner_index]
      exit_game_with_winner winner
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
