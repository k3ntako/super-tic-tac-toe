# frozen_string_literal: true

# GameEndEvaluator
class GameEndEvaluator
  def find_winner(board)
    [board.rows, board.columns, board.diagonals].each do |board_state|
      winner = find_winner_in_matrix board_state
      return winner unless winner.nil?
    end

    nil
  end

  private

  def find_winner_in_matrix(matrix)
    matrix.each do |row|
      winner = find_winner_in_array row
      return winner unless winner.nil?
    end

    nil
  end

  def find_winner_in_array(row)
    marks_present_in_row = row.uniq

    only_one_mark = marks_present_in_row.length == 1
    the_one_mark_is_not_nil = only_one_mark && !marks_present_in_row[0].nil?

    return marks_present_in_row[0] if the_one_mark_is_not_nil

    nil
  end
end
