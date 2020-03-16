require_relative './board'
require_relative './game_end_evaluator'

class MinimaxStrategy
  def initialize(game_end_evaluator:)
    @player = 'O'
    @opponent = 'X'
    @game_end_evaluator = game_end_evaluator
  end

  def get_move(board:)
    best_val = nil
    best_position = nil

    board.find_available_positions.each do |position|
      board.update(player, position) # make move

      move_val = minimax(board: board, depth: 0, is_max: false) # assess move

      board.update(nil, position) # undo move

      if best_val.nil? || best_val < move_val
        best_val = move_val
        best_position = position
      end
    end

    best_position
  end

  private

  attr_reader :game_end_evaluator, :player, :opponent

  def find_winner(board:)
    game_end_evaluator.find_winner(board: board)
  end

  def minimax(board:, depth:, is_max:)
    winner = find_winner(board: board)

    unless winner.nil?
      return (10 - depth) if winner == player
      return (-10 + depth) if winner == opponent
    end

    return 0 if board.find_available_positions.length.zero?

    continue_minimax(is_max: is_max, board: board, depth: depth)
  end

  def continue_minimax(is_max:, board:, depth:)
    best = nil
    current_player = is_max ? player : opponent

    board.find_available_positions.each do |position|
      board.update(current_player, position)

      potential_move = minimax(board: board, depth: depth + 1, is_max: !is_max)

      best = if best.nil?
               potential_move
             elsif is_max
               [best, potential_move].max
             else
               [best, potential_move].min
             end

      board.update(nil, position) # undo move
    end

    best
  end
end
