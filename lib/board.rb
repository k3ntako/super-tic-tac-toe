# frozen_string_literal: true

# Maintains the board state and makes updates based on moves
class Board
  def initialize
    @board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end

  def to_s
    board_str = ''

    @board.each_with_index do |row, row_idx|
      board_str += generate_board_row(row, row_idx)
    end

    board_str
  end

  def generate_board_row(row, row_idx)
    row_str = ''

    row.each_with_index do |_, square_idx|
      row_str += '   '
      row_str += square_idx < 2 ? '|' : '\n'
    end

    # add row divider
    row_str += '-----------\n' if row_idx < 2

    row_str
  end
end
