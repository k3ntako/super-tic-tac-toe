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
    return convert_to_position(indices: indices) unless indices.nil?

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

  def convert_to_position(indices:)
    matrix_idx, array_idx, position_idx = indices

    return convert_to_position_from_rows(array_idx: array_idx, position_idx: position_idx) if matrix_idx.zero?

    return convert_to_position_from_cols(array_idx: array_idx, position_idx: position_idx) if matrix_idx == 1

    convert_to_position_from_diagnoals(array_idx: array_idx, position_idx: position_idx) if matrix_idx == 2
  end

  def convert_to_position_from_rows(array_idx:, position_idx:)
    array_idx * 3 + position_idx + 1
  end

  def convert_to_position_from_cols(array_idx:, position_idx:)
    array_idx + position_idx * 3 + 1
  end

  def convert_to_position_from_diagnoals(array_idx:, position_idx:)
    board_width = 3
    mutlipler = board_width + 1 - (array_idx * 2)

    position_idx * mutlipler + array_idx * mutlipler + 1
  end
end
