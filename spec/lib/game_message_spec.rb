require_relative '../../lib/human_player'
require_relative '../../lib/game_message'

RSpec.describe GameMessage do
  let(:game_message) { GameMessage.new }
  let(:ui) { UserInterface.new(TestCLI.new) }

  describe 'generate' do
    it 'should return associated static message if no param is passed in' do
      output_message = game_message.generate(key: :not_valid_integer)

      expect(output_message).to eq 'Make sure it\'s an integer and try again!'
    end

    it 'should return game over message with a tie given no winner' do
      output_message = game_message.generate(key: :game_over, params: { winner: nil })

      expect(output_message).to eq 'Game Over: Tie!'
    end

    it 'should return game over message with the specified winner' do
      output_message_x = game_message.generate(key: :game_over, params: { winner: 'X' })
      expect(output_message_x).to eq 'Game Over: X Wins!'

      output_message_happiness = game_message.generate(key: :game_over, params: { winner: 'Happiness' })
      expect(output_message_happiness).to eq 'Game Over: Happiness Wins!'
    end

    it 'should return move instruction with the specified active user' do
      output_message_x = game_message.generate(key: :move_instruction, params: { current_player: 'O' })
      expect(output_message_x).to eq 'Enter a number to make a move in the corresponding square (O\'s turn):'

      output_message_happiness = game_message.generate(
        key: :move_instruction,
        params: { current_player: 'Happiness' }
      )
      expect(output_message_happiness).to eq(
        'Enter a number to make a move in the corresponding square (Happiness\'s turn):'
      )
    end

    it 'should return previous move' do
      output_message = game_message.generate(key: :previous_move, params: { player: 'O', position: 1 })
      expect(output_message).to eq 'Previous Move: O on 1'
    end

    it 'should return match up message' do
      players = [HumanPlayer.new(ui, 'X'), HumanPlayer.new(ui, 'O')]

      output_message = game_message.generate(
        key: :match_up,
        params: { players: players }
      )
      expect(output_message).to eq 'Human (X) vs. Human (O)'
    end

    it 'should return match up message with a computer' do
      players = [HumanPlayer.new(ui, 'X'), ComputerPlayer.new(mark: 'O', difficulty: :easy)]

      output_message = game_message.generate(
        key: :match_up,
        params: { players: players }
      )
      expect(output_message).to eq 'Human (X) vs. Computer (O)'
    end
  end
end
