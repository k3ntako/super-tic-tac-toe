class GameEndEvaluator
  def game_over?(board)
    player_won?(board) || !any_remaining_moves?(board)
  end

  def player_won?(board)
    !find_winner(board: board).nil?
  end

  def find_winner(board:)
    every_orientation_to_check = board.rows_cols_diagonals.flatten(1)

    find_winner_in_matrix(matrix: every_orientation_to_check)
  end

  private

  def any_remaining_moves?(board)
    board.find_available_positions.length.positive?
  end

  def find_winner_in_matrix(matrix:)
    array = matrix.shift
    winner = find_winner_in_array(array: array)

    return winner unless winner.nil?
    return nil if matrix.length.zero?

    find_winner_in_matrix(matrix: matrix)
  end

  def find_winner_in_array(array:)
    marks = array.uniq
    return marks[0] if marks.length == 1

    nil
  end
end
