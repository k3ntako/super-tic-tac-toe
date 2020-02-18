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
end
