class GameEndEvaluator
  def game_over?(board)
    player_won?(board) || !any_remaining_moves?(board)
  end

  def player_won?(board)
    !find_winner(board: board).nil?
  end

  def find_winner(board:)
    every_orientation_to_check = board.rows_cols_diagonals.flatten(1)

    find_winner_in_matrix(matrix: every_orientation_to_check, width: board.width)
  end

  private

  def any_remaining_moves?(board)
    board.find_available_positions.length.positive?
  end

  def find_winner_in_matrix(matrix:, width:)
    return 'X' if matrix.include? Array.new(width, 'X')
    return 'O' if matrix.include? Array.new(width, 'O')

    nil
  end
end
