require_relative '../../lib/board'

BOARD_WITH_MARKS = [
  ['X', 'X', nil],
  [nil, 'X', nil],
  [nil, 'X', 'X']
].freeze

RSpec.describe Board do
  let(:board) { Board.new(width: 3) }

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
    it 'should update the board when position (integer) is passed in as an string' do
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

    it 'should update the board at the specified position when position is passed in as an integer' do
      position = 2
      board.update('X', position)

      expect(board.state).to eq [
        [nil, 'X', nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]
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

  describe 'board_width' do
    it 'should return width of board' do
      board = Board.new(width: 3)
      expect(board.width).to eq 3

      board = Board.new(width: 5)
      expect(board.width).to eq 5

      board = Board.new(width: 6)
      expect(board.width).to eq 6
    end
  end

  describe 'board size' do
    it 'should create a board with the specified width' do
      board = Board.new(width: 5)

      expect(board.state.length).to eq 5
      expect(board.state[0].length).to eq 5

      board = Board.new(width: 9)

      expect(board.state.length).to eq 9
      expect(board.state[0].length).to eq 9
    end
  end
end
