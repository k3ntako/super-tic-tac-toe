# frozen_string_literal: true

# GameEndEvaluator
class GameEndEvaluator
  def find_winner(board)
    row_winner = find_winner_in_matrix board.board
    return row_winner unless row_winner.nil?

    col_winner = find_winner_in_matrix board.board.transpose
    return col_winner unless col_winner.nil?

    find_winner_in_matrix board.diagonals
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
    unique_marks = row.uniq

    return nil if unique_marks.length != 1 || unique_marks[0].nil?

    unique_marks[0]
  end
end
