require_relative '../../lib/move_validator'

RSpec.describe MoveValidator do
  let(:ui) do
    cli = CLI.new
    UserInterface.new(cli)
  end
  let(:game_messenger) { GameMessenger.new(ui) }
  let(:move_validator) { MoveValidator.new(game_messenger: game_messenger) }
  let(:board) { Board.new }

  describe 'move_valid?' do
    it 'should return true given an integer as a string' do
      is_valid = move_validator.move_valid?(board, '2')

      expect(is_valid).to be true
    end

    it 'should return true given an integer as a string surrounded by whitespace' do
      is_valid = move_validator.move_valid?(board, ' 2 ')

      expect(is_valid).to be true
    end

    it 'should return false given a non-integer string' do
      expect(game_messenger).to receive(:display_not_valid_integer)
      expect(game_messenger).not_to receive(:display_square_unavaliable)

      is_valid = move_validator.move_valid?(board, '1one')

      expect(is_valid).to be false
    end

    it 'should return false given a float' do
      expect(game_messenger).to receive(:display_not_valid_integer)
      expect(game_messenger).not_to receive(:display_square_unavaliable)

      is_valid = move_validator.move_valid?(board, 1.0)

      expect(is_valid).to be false
    end

    it 'should return false given nil' do
      expect(game_messenger).to receive(:display_not_valid_integer)
      expect(game_messenger).not_to receive(:display_square_unavaliable)

      is_valid = move_validator.move_valid?(board, nil)

      expect(is_valid).to be false
    end

    it 'should return false given white space' do
      expect(game_messenger).to receive(:display_not_valid_integer)
      expect(game_messenger).not_to receive(:display_square_unavaliable)

      is_valid = move_validator.move_valid?(board, ' ')

      expect(is_valid).to be false
    end

    it 'should return false given special characters' do
      expect(game_messenger).to receive(:display_not_valid_integer)
      expect(game_messenger).not_to receive(:display_square_unavaliable)

      is_valid = move_validator.move_valid?(board, '!')

      expect(is_valid).to be false
    end

    it 'should return true given the square is empty' do
      is_valid = move_validator.move_valid?(board, 1)

      expect(is_valid).to be true
    end

    it 'should return false given a position less than 1' do
      is_valid = move_validator.move_valid?(board, 0)

      expect(is_valid).to be false
    end

    it 'should return false given a position greater than 9' do
      is_valid = move_validator.move_valid?(board, 10)

      expect(is_valid).to be false
    end

    it 'should return false if the square is occupied' do
      board_played_at_one = [
        ['X', nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@board, board_played_at_one)

      is_valid = move_validator.move_valid?(board, 1)

      expect(is_valid).to be false
    end
  end
end
