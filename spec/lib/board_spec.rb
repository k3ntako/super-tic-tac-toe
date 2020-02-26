require_relative '../../lib/board'

BOARD_WITH_MARKS = [
  ['X', 'X', nil],
  [nil, 'X', nil],
  [nil, 'X', 'X']
].freeze

RSpec.describe Board do
  let(:board) { Board.new }

  describe 'state' do
    it 'should return an array of arrays with three nils in each' do
      expect(board.state).to eq [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]
    end
  end

  describe 'update' do
    context 'when position (integer) is passed in as an string' do
      it 'should update the board at the specified position' do
        position = '1'
        board.update('X', position)

        expect(board.state).to eq [
          ['X', nil, nil],
          [nil, nil, nil],
          [nil, nil, nil]
        ]

        position = '8'
        board.update('X', position)

        expect(board.state).to eq [
          ['X', nil, nil],
          [nil, nil, nil],
          [nil, 'X', nil]
        ]
      end
    end

    context 'when position (integer) is passed in as an integer' do
      it 'should update the board at the specified position' do
        position = 2
        board.update('X', position)

        expect(board.state).to eq [
          [nil, 'X', nil],
          [nil, nil, nil],
          [nil, nil, nil]
        ]
      end
    end
  end

  describe 'find_available_positions' do
    it 'should return an array of positions that are nil' do
      board.instance_variable_set(:@board, BOARD_WITH_MARKS)

      expect(board.find_available_positions).to eq [3, 4, 6, 7]
    end
  end

  describe 'rows_cols_diagonals' do
    it 'should return an array of matrices (arrays or arrays)' do
      board.instance_variable_set(:@board, BOARD_WITH_MARKS)

      expect(board.rows_cols_diagonals).to eq [
        BOARD_WITH_MARKS, # rows
        [ # columns
          ['X', nil, nil],
          ['X', 'X', 'X'],
          [nil, nil, 'X']
        ], [ # diagonals
          ['X', 'X', 'X'],
          [nil, 'X', nil]
        ]
      ]
    end
  end
end
