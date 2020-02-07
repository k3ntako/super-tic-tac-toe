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

  def make_move(piece, position)
    row = (position / 3).ceil # 3 is the width or row length
    col = position % 3 # 3 is the width or row length

    @board[row][col] = piece
  end
end
