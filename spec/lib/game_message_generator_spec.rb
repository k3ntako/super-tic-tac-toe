require_relative '../../lib/player'
require_relative '../../lib/game_message_generator'

RSpec.describe GameMessageGenerator do
  let(:game_message_generator) { GameMessageGenerator.new }
  # let(:board) { Board.new }
  # let(:test_user_interface) { TestUserInterface.new }
  # let(:game_messenger) { GameMessenger.new(user_interface: test_user_interface, messages: GAME_MESSENGER_MESSAGES) }
  # let(:player) { Player.new(user_interface, 'X') }

  describe 'message' do
    it 'should return associated static message if no param is passed in' do
      output_message = game_message_generator.message(key: :not_valid_integer)

      expect(output_message).to eq 'Make sure it\'s an integer and try again!'
    end

    it 'should return game over message with a tie given no winner' do
      output_message = game_message_generator.message(key: :game_over, params: { winner: nil })

      expect(output_message).to eq 'Game Over: Tie!'
    end

    it 'should return game over message with the specified winner' do
      output_message_x = game_message_generator.message(key: :game_over, params: { winner: 'X' })
      expect(output_message_x).to eq 'Game Over: X Wins!'

      output_message_happiness = game_message_generator.message(key: :game_over, params: { winner: 'Happiness' })
      expect(output_message_happiness).to eq 'Game Over: Happiness Wins!'
    end

    it 'should return move instruction with the specified active user' do
      output_message_x = game_message_generator.message(key: :move_instruction, params: { current_player: 'O' })
      expect(output_message_x).to eq 'Enter a number to make a move in the corresponding square (O\'s turn):'

      output_message_happiness = game_message_generator.message(
        key: :move_instruction,
        params: { current_player: 'Happiness' }
      )
      expect(output_message_happiness).to eq(
        'Enter a number to make a move in the corresponding square (Happiness\'s turn):'
      )
    end
  end
end
