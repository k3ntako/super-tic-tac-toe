# frozen_string_literal: true

require_relative '../../lib/board'

RSpec.describe 'Board' do
  context 'when Board#board is called' do
    it 'should return an array of arrays with three nils in each' do
      board_instance = Board.new
      board = board_instance.board

      expect(board).to eq [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]
    end
  end
end
