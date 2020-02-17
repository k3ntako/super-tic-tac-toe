# frozen_string_literal: true

# Maintains the board state and makes updates based on moves
class Board
  attr_reader :board

  def initialize
    @board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end

  def position_to_row(position)
    # convert to zero-based numbering
    position -= 1

    # assumes 3 x 3 board
    (position / 3).ceil # 3 is number of cols
  end

  def position_to_col(position)
    # convert to zero-based numbering
    position -= 1

    # assumes 3 x 3 board
    position % 3 # 3 is number of rows
  end

  def move_valid?(position)
    # Accepts an integer or string
    return false if (!position.is_a? Integer) && (!position.is_a? String)

    # Strings will be converted to integer using Integer
    # Valid strings: "1", "  1 ", " 2 \n", " 2 \r\n"
    # Invalid strings: "", "aa", "a1", "1a", "1 2", "1.1"
    begin
      position = Integer position
    rescue ArgumentError
      return false
    end

    return false if position < 1 || position > 9

    row = position_to_row position
    col = position_to_col position

    # Check if specified location is already occupied
    @board[row][col].nil?
  end
end
