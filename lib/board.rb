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
end
