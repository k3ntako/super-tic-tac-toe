require_relative '../../lib/move_validator'

RSpec.describe MoveValidator do
  let(:ui) do
    cli = CLI.new
    UserInterface.new(cli)
  end
  let(:game_messenger) { GameMessenger.new(user_interface: ui, messages: {}) }
  let(:move_validator) { MoveValidator.new }
  let(:board) { Board.new }

  describe 'move_error' do
    it 'should return true given an integer as a string' do
      error_symbol = move_validator.move_error(board, '2')

      expect(error_symbol).to be nil
    end

    it 'should return true given an integer as a string surrounded by whitespace' do
      error_symbol = move_validator.move_error(board, ' 2 ')

      expect(error_symbol).to be nil
    end

    it 'should return false given a non-integer string' do
      error_symbol = move_validator.move_error(board, '1one')

      expect(error_symbol).to eq :not_valid_integer
    end

    it 'should return false given a float' do
      error_symbol = move_validator.move_error(board, 1.0)

      expect(error_symbol).to eq :not_valid_integer
    end

    it 'should return false given nil' do
      error_symbol = move_validator.move_error(board, nil)

      expect(error_symbol).to eq :not_valid_integer
    end

    it 'should return false given white space' do
      error_symbol = move_validator.move_error(board, ' ')

      expect(error_symbol).to eq :not_valid_integer
    end

    it 'should return false given special characters' do
      error_symbol = move_validator.move_error(board, '!')

      expect(error_symbol).to eq :not_valid_integer
    end

    it 'should return true given the square is empty' do
      error_symbol = move_validator.move_error(board, 1)

      expect(error_symbol).to be nil
    end

    it 'should return false given a position less than 1' do
      error_symbol = move_validator.move_error(board, 0)

      expect(error_symbol).to eq :square_unavailable
    end

    it 'should return false given a position greater than 9' do
      error_symbol = move_validator.move_error(board, 10)

      expect(error_symbol).to eq :square_unavailable
    end

    it 'should return false if the square is occupied' do
      board_played_at_one = [
        ['X', nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@board, board_played_at_one)

      error_symbol = move_validator.move_error(board, 1)

      expect(error_symbol).to eq :square_unavailable
    end
  end
end
