# frozen_string_literal: true

require_relative '../../lib/board'

RSpec.describe 'Board' do
  let(:board) { Board.new }

  context 'when Board#board is called' do
    it 'should return an array of arrays with three nils in each' do
      expect(board.board).to eq [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]
    end
  end

  context 'when make_move is called with a move' do
    it 'should make a change to the @board' do
      position = 0
      board.make_move('X', position)

      expect(board.board).to eq [
        ['X', nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]

      position = 3
      board.make_move('X', position)

      expect(board.board).to eq [
        ['X', nil, nil],
        ['X', nil, nil],
        [nil, nil, nil]
      ]

      position = 4
      board.make_move('X', position)

      expect(board.board).to eq [
        ['X', nil, nil],
        ['X', 'X', nil],
        [nil, nil, nil]
      ]

      position = 8
      board.make_move('X', position)

      expect(board.board).to eq [
        ['X', nil, nil],
        ['X', 'X', nil],
        [nil, nil, 'X']
      ]
    end
  end
end
