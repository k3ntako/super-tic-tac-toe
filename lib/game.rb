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
    one_turn
  end

  private

  def one_turn
    display_move_instruction

    prompt_move

    display_board

    game_end_evaluator = GameEndEvaluator.new
    winner = game_end_evaluator.find_winner(@board)
    return exit_game_with_winner active_player unless winner.nil?

    does_remaining_moves_exist = game_end_evaluator.any_remaining_moves?(@board)
    return exit_game_with_tie unless does_remaining_moves_exist

    alertnate_active_player

    one_turn
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

  def exit_game_with_winner(winner)
    message = "Game Over: #{winner.mark} Wins"
    @user_interface.display_message message
  end

  def exit_game_with_tie
    message = 'Game Over: Tie!'
    @user_interface.display_message message
  end
end
