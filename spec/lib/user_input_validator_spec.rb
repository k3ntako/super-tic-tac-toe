require_relative '../../lib/user_input_validator'

RSpec.describe UserInputValidator do
  let(:user_input_validator) { UserInputValidator.new }
  let(:board) { Board.new }

  describe 'move_valid_integer? ' do
    context 'when called with an integer' do
      it 'should return true' do
        is_valid = user_input_validator.move_valid_integer? 1

        expect(is_valid).to be true
      end
    end

    context 'when called with an integer as a string' do
      it 'should return true' do
        is_valid = user_input_validator.move_valid_integer? '2'

        expect(is_valid).to be true
      end
    end

    context 'when called with an non-integer string' do
      it 'should return false' do
        is_valid = user_input_validator.move_valid_integer? '1one'

        expect(is_valid).to be false
      end
    end

    context 'when called with a float' do
      it 'should return false' do
        is_valid = user_input_validator.move_valid_integer? 1.0

        expect(is_valid).to be false
      end
    end
  end

  describe 'move_on_empty_square?' do
    context 'when the specified square is empty' do
      it 'should return true' do
        is_valid = user_input_validator.move_on_empty_square?(board, 1)

        expect(is_valid).to be true
      end
    end

    context 'when called with a value less than 1' do
      it 'should return false' do
        is_valid = user_input_validator.move_on_empty_square?(board, 0)

        expect(is_valid).to be false
      end
    end

    context 'when called with a value greater than 9' do
      it 'should return false ' do
        is_valid = user_input_validator.move_on_empty_square?(board, 10)

        expect(is_valid).to be false
      end
    end

    context 'when there is already a mark' do
      it 'should return false' do
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
end
