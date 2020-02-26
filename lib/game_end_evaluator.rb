class GameEndEvaluator
  def game_over?(board)
    player_won?(board) || !any_remaining_moves?(board)
  end

  def player_won?(board)
    every_orientation_to_check = board.rows_cols_diagonals.flatten(1)

    player_won_in_matrix? every_orientation_to_check
  end

  private

  def any_remaining_moves?(board)
    board.find_available_positions.length.positive?
  end

  def player_won_in_matrix?(matrix)
    array = matrix.shift

    return true if array_has_winner? array
    return player_won_in_matrix? matrix if matrix.length.positive?

    false
  end

  def array_has_winner?(array)
    array.count('X') == array.length || array.count('O') == array.length
  end
end
