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

  context 'when Board.to_s is called with an empty board' do
    it 'should print an empty board to the console' do
      expected_output =
        '   |   |   \n' \
        '-----------\n' \
        '   |   |   \n' \
        '-----------\n' \
        '   |   |   \n'

      board = Board.new

      board_str = board.to_s
      expect(board_str).to eq expected_output
    end
  end
end
