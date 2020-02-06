# frozen_string_literal: true

require_relative '../../lib/cli'
require_relative '../../lib/tic_tac_toe'

RSpec.describe 'TicTacToe' do
  context 'when the user starts the game' do
    it 'should print a welcome message' do
      cli = CLI.new

      expected_message = 'Welcome to a game of Tic-Tac-Toe!'
      expect(cli).to receive(:put_string).with(expected_message).once

      tic_tac_toe = TicTacToe.new(cli)
      tic_tac_toe.print_welcome
    end
  end
end
