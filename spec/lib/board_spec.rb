# frozen_string_literal: true

require_relative '../../lib/board'

RSpec.describe 'Board' do
  let(:board) { Board.new }

  context 'when Board#board is called' do
    it 'should return an array of arrays with three nils in each' do
      # Allows access to private instance variable
      board_array = board.instance_variable_get(:@board)

      expect(board_array).to eq [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]
    end
  end

  context 'when find_available_positions is called' do
    it 'should return an array of positions that are nil' do
      board_with_marks = [
        ['X', 'X', nil],
        [nil, 'X', nil],
        [nil, 'X', 'X']
      ]

      board.instance_variable_set(:@board, board_with_marks)

      expect(board.find_available_positions).to eq [3, 4, 6, 7]
    end
  end
end
