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

  def available?(position)
    positions = available_positions

    positions.include? position
  end

  def available_positions
    flat_board = board.flatten

    positions = []
    flat_board.each_with_index do |mark, idx|
      positions.push(idx + 1) if mark.nil?
    end

    positions
  end
end
