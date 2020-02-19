require_relative '../../lib/user_input_validator'

RSpec.describe UserInputValidator do
  let(:user_input_validator) { UserInputValidator.new }
  let(:board) { Board.new }

  context 'when move_valid_integer? is called with a string' do
    it 'should return true given a valid position' do
      is_valid = user_input_validator.move_valid_integer? 1

      expect(is_valid).to be true
    end

    it 'should return true given a valid position as a string' do
      is_valid = user_input_validator.move_valid_integer? '2'

      expect(is_valid).to be true
    end

    it 'should return false if value is a string with non-integers' do
      is_valid = user_input_validator.move_valid_integer? '1one'

      expect(is_valid).to be false
    end

    it 'should return false if value is a float' do
      is_valid = user_input_validator.move_valid_integer? 1.0

      expect(is_valid).to be false
    end
  end

  context 'when move_on_empty_square? is called with a valid string' do
    it 'should return false if value is less than 1' do
      is_valid = user_input_validator.move_on_empty_square?(board, 0)

      expect(is_valid).to be false
    end

    it 'should return false if value is greater than 9' do
      is_valid = user_input_validator.move_on_empty_square?(board, 10)

      expect(is_valid).to be false
    end

    it 'should return true if specified square is empty' do
      is_valid = user_input_validator.move_on_empty_square?(board, 1)

      expect(is_valid).to be true
    end

    it 'should return false if position already has a mark' do
      board_played_at_one = [
        ['X', nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@board, board_played_at_one)

      is_valid = user_input_validator.move_on_empty_square?(board, 1)

      expect(is_valid).to be false
    end
  end
end
