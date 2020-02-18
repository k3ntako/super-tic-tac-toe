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

  def occupied?(position)
    row = position_to_row position
    col = position_to_col position

    @board[row][col].nil?
  end
end
