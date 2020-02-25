class GameEndEvaluator
  def game_over?(board)
    did_player_win = player_won?(board)

    did_player_win || !any_remaining_moves?(board)
  end

  def player_won?(board)
    [board.rows, board.columns, board.diagonals].each do |board_state|
      winner = find_winner_in_matrix board_state
      return true unless winner.nil?
    end

    false
  end

  private

  def any_remaining_moves?(board)
    board.find_available_positions.length.positive?
  end

  def find_winner_in_matrix(matrix)
    matrix.each do |row|
      winner = find_winner_in_array row
      return winner unless winner.nil?
    end

    nil
  end

  def find_winner_in_array(array)
    marks_present_in_array = array.uniq

    only_one_mark = marks_present_in_array.length == 1
    the_one_mark_is_not_nil = only_one_mark && !marks_present_in_array[0].nil?

    return marks_present_in_array[0] if the_one_mark_is_not_nil

    nil
  end
end
