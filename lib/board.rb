class Board
  def initialize(width: 3)
    @board = generate_empty_board(width: width)
  end

  def state
    board
  end

  def width
    board.length
  end

  def position_available?(position)
    available_positions = find_available_positions

    available_positions.include? Integer(position)
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

  def rows_cols_diagonals
    [rows, columns, diagonals]
  end

  private

  attr_reader :board

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

  def position_to_row(position)
    zero_based_position = position.to_i - 1
    (zero_based_position / board.length).ceil
  end

  def position_to_col(position)
    zero_based_position = position.to_i - 1
    zero_based_position % board.length
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

  def generate_empty_board(width:)
    board = []
    width.times { |_| board.push(Array.new(width, nil)) }

    board
  end
end
