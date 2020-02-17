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

  context 'when position_to_row_and_col' do
    it 'should return an array with row and col given 1 for position' do
      row_col = board.position_to_row_and_col 1
      row = row_col[0]
      col = row_col[1]

      expect(row).to equal(0)
      expect(col).to equal(0)
    end

    it 'should return an array with row and col given 8 for position' do
      row_col = board.position_to_row_and_col 8
      row = row_col[0]
      col = row_col[1]

      expect(row).to equal(2)
      expect(col).to equal(1)
    end
  end

  context 'when make_move is called with a move' do
    it 'should make a change to the @board' do
      position = '1'
      board.make_move('X', position)

      expect(board.board).to eq [
        ['X', nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]

      position = '4'
      board.make_move('X', position)

      expect(board.board).to eq [
        ['X', nil, nil],
        ['X', nil, nil],
        [nil, nil, nil]
      ]

      position = '5'
      board.make_move('X', position)

      expect(board.board).to eq [
        ['X', nil, nil],
        ['X', 'X', nil],
        [nil, nil, nil]
      ]

      position = '9'
      board.make_move('X', position)

      expect(board.board).to eq [
        ['X', nil, nil],
        ['X', 'X', nil],
        [nil, nil, 'X']
      ]
    end

    it 'should accept integer as position argument' do
      position = 2
      board.make_move('X', position)

      expect(board.board).to eq [
        [nil, 'X', nil],
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
