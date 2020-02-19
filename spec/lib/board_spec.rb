require_relative '../../lib/board'

BOARD_WITH_MARKS = [
  ['X', 'X', nil],
  [nil, 'X', nil],
  [nil, 'X', 'X']
].freeze

RSpec.describe 'Board' do
  let(:board) { Board.new }

  context 'when Board#state is called' do
    it 'should return an array of arrays with three nils in each' do
      expect(board.state).to eq [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]
    end
  end

  context 'when update is called with a move' do
    it 'should make a change to the @board' do
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

    it 'should accept integer as position argument' do
      position = 2
      board.update('X', position)

      expect(board.state).to eq [
        [nil, 'X', nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]
    end
  end

  context 'when find_available_positions is called' do
    it 'should return an array of positions that are nil' do
      board.instance_variable_set(:@board, BOARD_WITH_MARKS)

      expect(board.find_available_positions).to eq [3, 4, 6, 7]
    end
  end

  context 'when columns is called' do
    it 'should return an array of arrays with the columns' do
      board.instance_variable_set(:@board, BOARD_WITH_MARKS)

      expect(board.columns).to eq [
        ['X', nil, nil],
        ['X', 'X', 'X'],
        [nil, nil, 'X']
      ]
    end
  end

  context 'when diagonals is called' do
    it 'should return an array of arrays with both diagonals' do
      board.instance_variable_set(:@board, BOARD_WITH_MARKS)

      expect(board.diagonals).to eq [
        ['X', 'X', 'X'],
        [nil, 'X', nil]
      ]
    end
  end
end
