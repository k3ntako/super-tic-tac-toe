class Board
  def initialize
    @board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end

  def state
    @board
  end

  def position_available?(position)
    available_positions = find_available_positions

    available_positions.include? position
  end

  def find_available_positions
    flat_board = @board.flatten

    flat_board.each_with_index.each_with_object([]) do |(mark, idx), available_positions|
      available_positions.push(idx + 1) if mark.nil?
    end
  end

  def update(mark, position)
    row = position_to_row position
    col = position_to_col position

    @board[row][col] = mark
  end

  def rows
    @board
  end

  def columns
    @board.transpose
  end

  def diagonals
    [
      left_to_right_diagonal,
      right_to_left_diagonal
    ]
  end

  private

  def position_to_row(position)
    zero_based_position = position.to_i - 1
    (zero_based_position / 3).ceil # 3 is number of cols
  end

  def position_to_col(position)
    zero_based_position = position.to_i - 1
    zero_based_position % 3 # 3 is number of rows
  end

  def left_to_right_diagonal
    (0..@board.length - 1).map do |idx|
      @board[idx][idx]
    end
  end

  def right_to_left_diagonal
    (0..@board.length - 1).map do |idx|
      @board[idx][@board.length - 1 - idx]
    end
  end
end
