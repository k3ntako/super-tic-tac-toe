class MediumStrategy
  def initialize
    @should_try_middle = true
  end

  def get_move(board:)
    @should_try_middle &&= board.position_available?(5)

    if @should_try_middle
      @should_try_middle = false
      return 5
    end

    indices = find_position_one_away_from_winning(board: board)
    return convert_to_position(indices: indices, width: board.state.length) unless indices.nil?

    rand(1...9)
  end

  private

  def find_position_one_away_from_winning(board:)
    matrix_idx = nil
    array_idx = nil
    position_idx = nil

    board.rows_cols_diagonals.each_with_index do |matrix, m_idx|
      matrix.each_with_index do |array, a_idx|
        contains_two_and_a_nil = (array.count('X') == 2 || array.count('O') == 2) && array.include?(nil)
        next unless contains_two_and_a_nil

        matrix_idx = m_idx
        array_idx = a_idx
        position_idx = array.find_index nil

        return [matrix_idx, array_idx, position_idx]
      end
    end

    nil
  end

  def convert_to_position(indices:, width:)
    matrix_idx, array_idx, position_idx = indices

    [
      convert_to_position_from_rows,
      convert_to_position_from_cols,
      convert_to_position_from_diagnoals
    ][matrix_idx].call(array_idx, position_idx, width)
  end

  def convert_to_position_from_rows
    proc do |array_idx, position_idx, width|
      array_idx * width + position_idx + 1
    end
  end

  def convert_to_position_from_cols
    proc do |array_idx, position_idx, width|
      array_idx + position_idx * width + 1
    end
  end

  def convert_to_position_from_diagnoals
    proc do |array_idx, position_idx, width|
      mutlipler = width + 1 - (array_idx * 2)

      position_idx * mutlipler + array_idx * mutlipler + 1
    end
  end
end
