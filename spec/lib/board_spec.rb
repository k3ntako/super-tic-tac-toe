# frozen_string_literal: true

require_relative '../../lib/board'

RSpec.describe 'Board' do
  context 'when Board#board is called' do
    it 'should return an array of arrays with three nils in each' do
      board_instance = Board.new

      # Allows access to private instance variable
      board = board_instance.instance_variable_get(:@board)

      expect(board).to eq [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]
    end
  end

  context 'when move_valid? is called with a position' do
    it 'should return true given a valid position' do
      board = Board.new
      is_valid = board.move_valid? 1

      expect(is_valid).to be true
    end

    it 'should return true given a valid position as a string' do
      board = Board.new
      is_valid = board.move_valid? '2'

      expect(is_valid).to be true
    end

    it 'should return false if value is less than 1' do
      board = Board.new
      is_valid = board.move_valid? 0

      expect(is_valid).to be false
    end

    it 'should return false if value is greater than 0' do
      board = Board.new
      is_valid = board.move_valid? 10

      expect(is_valid).to be false
    end

    it 'should return false if value is a string with non-integers' do
      board = Board.new
      is_valid = board.move_valid? '1one'

      expect(is_valid).to be false
    end

    it 'should return false if value is a float' do
      board = Board.new
      is_valid = board.move_valid? 1.0

      expect(is_valid).to be false
    end

    it 'should return false if position already has a piece' do
      board = Board.new
      board_played_at_one = [
        ['X', nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@board, board_played_at_one)

      is_valid = board.move_valid? 1

      expect(is_valid).to be false
    end
  end
end
