# frozen_string_literal: true

require_relative '../../lib/tic_tac_toe'

RSpec.describe 'TicTacToe' do
  context 'when the user starts the game' do
    it 'should print a welcome message' do
      tic_tac_toe = TicTacToe.new
      expected_message = 'Welcome to a game of Tic-Tac-Toe!\n'

      expect { tic_tac_toe.print_welcome }.to output(expected_message).to_stdout
    end
  end
end
