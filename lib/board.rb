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

  def state
    @board
  end

  def position_available?(position)
    available_positions = find_available_positions

    available_positions.include? position
  end

  def find_available_positions
    flat_board = board.flatten

    available_positions = []
    flat_board.each_with_index do |mark, idx|
      available_positions.push(idx + 1) if mark.nil?
    end

    available_positions
  end

  def make_move(piece, position)
    row = (position / 3).ceil # 3 is col count
    col = position % 3 # 3 is row count

    @board[row][col] = piece
  end

  def position_to_row(position)
    zero_based_position = position.to_i - 1
    (zero_based_position / 3).ceil # 3 is number of cols
  end

  def position_to_col(position)
    zero_based_position = position.to_i - 1
    zero_based_position % 3 # 3 is number of rows
  end
end
