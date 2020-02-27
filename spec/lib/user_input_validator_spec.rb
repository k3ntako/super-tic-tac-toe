require_relative '../../lib/move_validator'

RSpec.describe MoveValidator do
  let(:move_validator) { MoveValidator.new }
  let(:board) { Board.new }

  describe 'valid_integer? ' do
    it 'should return true given a negative integer' do
      is_valid = move_validator.valid_integer?(-1)

      expect(is_valid).to be true
    end

    it 'should return true given an integer as a string' do
      is_valid = move_validator.valid_integer? '2'

      expect(is_valid).to be true
    end

    it 'should return true given an integer as a string surrounded by whitespace' do
      is_valid = move_validator.valid_integer? ' 2 '

      expect(is_valid).to be true
    end

    it 'should return false given a non-integer string' do
      is_valid = move_validator.valid_integer? '1one'

      expect(is_valid).to be false
    end

    it 'should return false given a float' do
      is_valid = move_validator.valid_integer? 1.0

      expect(is_valid).to be false
    end

    it 'should return false given nil' do
      is_valid = move_validator.valid_integer? nil

      expect(is_valid).to be false
    end

    it 'should return false given white space' do
      is_valid = move_validator.valid_integer? ' '

      expect(is_valid).to be false
    end

    it 'should return false given special characters' do
      is_valid = move_validator.valid_integer? '!'

      expect(is_valid).to be false
    end
  end

  describe 'empty_square?' do
    it 'should return true given the square is empty' do
      is_valid = move_validator.empty_square?(board, 1)

      expect(is_valid).to be true
    end

    it 'should return false given a position less than 1' do
      is_valid = move_validator.empty_square?(board, 0)

      expect(is_valid).to be false
    end

    it 'should return false given a position greater than 9' do
      is_valid = move_validator.empty_square?(board, 10)

      expect(is_valid).to be false
    end

    it 'should return false if the square is occupied' do
      board_played_at_one = [
        ['X', nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@board, board_played_at_one)

      is_valid = move_validator.empty_square?(board, 1)

      expect(is_valid).to be false
    end
  end
end
