require_relative '../../lib/medium_strategy'

RSpec.describe MediumStrategy do
  let(:board) { Board.new }
  let(:medium_strategy) { MediumStrategy.new }

  describe 'get_move' do
    it 'should return middle if available' do
      expect(medium_strategy.get_move(board: board)).to eq 5
    end

    it 'should randomly select a location if middle is taken' do
      board_state = [
        [nil, nil, nil],
        [nil, 'X', nil],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@board, board_state)

      10.times do
        position = medium_strategy.get_move(board: board)
        expect(position).to be_between(1, 9)
      end
    end

    it 'should block opponent from winning if they are a move away (horizontal)' do
      board_state = [
        [nil, nil, nil],
        ['X', 'X', nil],
        [nil, 'O', nil]
      ]

      board.instance_variable_set(:@board, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 6
    end

    it 'should block opponent from winning if they are a move away (vertical)' do
      board_state = [
        ['X', 'X', 'O'],
        ['X', 'O', nil],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@board, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 7
    end

    it 'should block opponent from winning if they are a move away (diagonal)' do
      board_state = [
        ['X', nil, 'O'],
        ['O', 'X', nil],
        ['O', nil, nil]
      ]

      board.instance_variable_set(:@board, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 9
    end

    it 'should try to win if it is a move away (horizontal)' do
      board_state = [
        ['O', 'O', nil],
        [nil, 'X', 'X'],
        [nil, 'X', nil]
      ]

      board.instance_variable_set(:@board, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 3
    end

    it 'should try to win if it is a move away (vertical)' do
      board_state = [
        ['X', 'O', 'X'],
        [nil, 'O', 'X'],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@board, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 8
    end

    it 'should try to win if it is a move away (diagonal)' do
      board_state = [
        ['O', nil, 'X'],
        ['X', 'O', nil],
        ['X', nil, nil]
      ]

      board.instance_variable_set(:@board, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 9
    end
  end
end
