require_relative '../../lib/medium_strategy'

RSpec.describe MediumStrategy do
  let(:medium_strategy) { MediumStrategy.new }

  describe 'get_move' do
    it 'should return middle if available' do
      board = Board.new(width: 3)
      expect(medium_strategy.get_move(board: board)).to eq 5
    end

    it 'should return middle if available on a larger board' do
      board = Board.new(width: 5)
      expect(medium_strategy.get_move(board: board)).to eq 13
    end

    it 'should randomly select a location if middle is taken' do
      board = Board.new(width: 3)
      board_state = [
        [nil, nil, nil],
        [nil, 'X', nil],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@state, board_state)

      10.times do
        position = medium_strategy.get_move(board: board)
        expect(position).to be_between(1, 9)
      end
    end

    it 'should block opponent from winning if they are a move away (horizontal)' do
      board = Board.new(width: 3)
      board_state = [
        [nil, nil, nil],
        ['X', 'X', nil],
        [nil, 'O', nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 6
    end

    it 'should block opponent from winning if they are a move away (horizontal - larger board)' do
      board = Board.new(width: 7)
      board_state = [
        ['X', 'X', 'X', 'X', 'X', 'X', nil],
        ['O', nil, nil, nil, nil, nil, nil],
        [nil, 'O', nil, nil, nil, nil, nil],
        ['O', nil, nil, 'O', nil, nil, nil],
        [nil, 'O', nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 7
    end

    it 'should block opponent from winning if they are a move away (vertical)' do
      board = Board.new(width: 3)
      board_state = [
        ['X', 'X', 'O'],
        ['X', 'O', nil],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 7
    end

    it 'should block opponent from winning if they are a move away (vertical - larger board)' do
      board = Board.new(width: 6)
      board_state = [
        ['X', nil, nil, nil, nil, nil],
        ['X', nil, nil, nil, nil, nil],
        ['X', 'O', nil, nil, nil, nil],
        ['X', nil, 'O', 'O', nil, nil],
        ['X', 'O', nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 31
    end

    it 'should block opponent from winning if they are a move away (diagonal)' do
      board = Board.new(width: 3)
      board_state = [
        ['X', nil, 'O'],
        ['O', 'X', nil],
        ['O', nil, nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 9
    end

    it 'should block opponent from winning if they are a move away (diagonal - larger board)' do
      board = Board.new(width: 9)
      board_state = [
        ['X', nil, nil, nil, nil, nil, nil, nil, nil],
        ['O', 'X', nil, nil, nil, nil, nil, nil, nil],
        ['O', 'O', 'X', nil, nil, nil, nil, nil, nil],
        ['O', nil, 'O', 'X', nil, nil, nil, nil, nil],
        ['O', 'O', nil, nil, 'X', nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, 'X', nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, 'X', nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, 'X', nil],
        [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 81
    end

    it 'should try to win if it is a move away (horizontal)' do
      board = Board.new(width: 3)
      board_state = [
        ['O', 'O', nil],
        [nil, 'X', 'X'],
        [nil, 'X', nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 3
    end

    it 'should try to win if it is a move away (horizontal - larger board)' do
      board = Board.new(width: 4)
      board_state = [
        ['O', 'O', 'O', nil],
        [nil, 'X', 'X', nil],
        [nil, 'X', nil, nil],
        [nil, 'X', nil, nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 4
    end

    it 'should try to win if it is a move away (vertical)' do
      board = Board.new(width: 3)
      board_state = [
        ['X', 'O', 'X'],
        [nil, 'O', 'X'],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 8
    end

    it 'should try to win if it is a move away (vertical - larger board)' do
      board = Board.new(width: 8)
      board_state = [
        ['O', nil, nil, nil, nil, nil, nil, nil],
        ['O', 'X', nil, nil, nil, nil, nil, nil],
        ['O', nil, 'X', nil, nil, nil, nil, nil],
        ['O', 'X', 'X', 'X', nil, nil, nil, nil],
        ['O', 'X', nil, nil, 'X', nil, nil, nil],
        ['O', nil, nil, nil, nil, 'X', nil, nil],
        ['O', nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 57
    end

    it 'should try to win if it is a move away (diagonal)' do
      board = Board.new(width: 3)
      board_state = [
        ['O', nil, 'X'],
        ['X', 'O', nil],
        ['X', nil, nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 9
    end

    it 'should try to win if it is a move away (diagonal - larger board)' do
      board = Board.new(width: 6)
      board_state = [
        ['O', nil, 'X', nil, nil, nil],
        ['X', nil, nil, nil, 'O', nil],
        ['X', 'X', nil, 'O', nil, nil],
        ['X', 'X', 'O', nil, nil, nil],
        ['X', 'O', nil, nil, 'X', nil],
        ['O', nil, nil, nil, 'O', nil]
      ]

      board.instance_variable_set(:@state, board_state)
      expect(medium_strategy.get_move(board: board)).to eq 6
    end
  end
end
