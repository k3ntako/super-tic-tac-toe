class Board
  attr_reader :state, :width
  def initialize(width:)
    @state = generate_empty_board(width: width)
    @width = width
  end

  def position_available?(position)
    available_positions = find_available_positions

    available_positions.include? Integer(position)
  end

  def find_available_positions
    flat_board = state.flatten

    flat_board.each_with_index.each_with_object([]) do |(mark, idx), available_positions|
      available_positions.push(idx + 1) if mark.nil?
    end
  end

  def update(mark, position)
    row = position_to_row position
    col = position_to_col position

    state[row][col] = mark
  end

  def rows_cols_diagonals
    [rows, columns, diagonals]
  end

  private

  def rows
    state
  end

  def columns
    state.transpose
  end

  def diagonals
    [
      left_to_right_diagonal,
      right_to_left_diagonal
    ]
  end

  def position_to_row(position)
    zero_based_position = position.to_i - 1
    (zero_based_position / width).ceil
  end

  def position_to_col(position)
    zero_based_position = position.to_i - 1
    zero_based_position % width
  end

  def left_to_right_diagonal
    (0..width - 1).map do |idx|
      state[idx][idx]
    end
  end

  def right_to_left_diagonal
    (0..width - 1).map do |idx|
      state[idx][width - 1 - idx]
    end
  end

  def generate_empty_board(width:)
    new_state = []
    width.times { |_| new_state.push(Array.new(width, nil)) }

    new_state
  end
end
