require_relative '../../lib/input_validator'

RSpec.describe InputValidator do
  let(:ui) do
    cli = CLI.new
    UserInterface.new(cli)
  end
  let(:game_messenger) { GameMessenger.new(user_interface: ui, message_generator: GameMessage.new) }
  let(:input_validator) { InputValidator.new }
  let(:board) { Board.new }

  describe 'move_error' do
    it 'should return true given an integer as a string' do
      error_symbol = input_validator.move_error(board, '2')

      expect(error_symbol).to be nil
    end

    it 'should return true given an integer as a string surrounded by whitespace' do
      error_symbol = input_validator.move_error(board, ' 2 ')

      expect(error_symbol).to be nil
    end

    it 'should return false given a non-integer string' do
      input_validator.move_error(board, '1one')
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return false given a float' do
      input_validator.move_error(board, 1.0)
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return false given nil' do
      input_validator.move_error(board, nil)
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return false given white space' do
      input_validator.move_error(board, ' ')
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return false given special characters' do
      input_validator.move_error(board, '!')
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return true given the square is empty' do
      error_symbol = input_validator.move_error(board, 1)

      expect(error_symbol).to be nil
    end

    it 'should return false given a position less than 1' do
      input_validator.move_error(board, 0)

      raise 'Expected error to be thrown'
    rescue SquareUnavailableError => e
      expect(e.message_symbol).to eq :square_unavailable
    end

    it 'should return false given a position greater than 9' do
      input_validator.move_error(board, 10)

      raise 'Expected error to be thrown'
    rescue SquareUnavailableError => e
      expect(e.message_symbol).to eq :square_unavailable
    end

    it 'should return false if the square is occupied' do
      board_played_at_one = [
        ['X', nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]

      board.instance_variable_set(:@board, board_played_at_one)

      input_validator.move_error(board, 1)
      raise 'Expected error to be thrown'
    rescue SquareUnavailableError => e
      expect(e.message_symbol).to eq :square_unavailable
    end
  end

  describe 'input_error' do
    it 'should return error given nil' do
      input_validator.input_error(nil)
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return error given empty string' do
      input_validator.input_error('')
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return error given a string with alphabet characters' do
      input_validator.input_error('527ck1129')
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return error given a string with special characters' do
      input_validator.input_error('!')
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return error given a float' do
      input_validator.input_error(1.2)
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return error given a float string' do
      input_validator.input_error('1.2')
      raise 'Expected error to be thrown'
    rescue IntegerError => e
      expect(e.message_symbol).to eq :not_valid_integer
    end

    it 'should return nil given an integer' do
      expect(input_validator.input_error(807)).to eq nil
    end

    it 'should return nil given a string with only numbers' do
      expect(input_validator.input_error('807')).to eq nil
    end

    it 'should return nil given a string with numbers and white space' do
      expect(input_validator.input_error(" 1123\n")).to eq nil
    end
  end
end
