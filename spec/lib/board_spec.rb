require_relative '../../lib/board'

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
