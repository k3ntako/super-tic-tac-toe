# frozen_string_literal: true

require_relative '../../lib/cli'
require_relative '../../lib/board'
require_relative '../../lib/tic_tac_toe'

RSpec.describe 'TicTacToe' do
  let(:cli) { CLI.new }

  context 'when TicTacToe is initialized' do
    it 'should have instances of CLI and Board as instance variables' do
      tic_tac_toe = TicTacToe.new(cli)

      # Allows access to private instance variable
      private_cli = tic_tac_toe.instance_variable_get(:@cli)
      expect(private_cli).to be_kind_of CLI

      private_board = tic_tac_toe.instance_variable_get(:@board)
      expect(private_board).to be_kind_of Board
    end
  end

  context 'when print_welcome is called' do
    it 'should print a welcome message' do
      expected_message = 'Welcome to a game of Tic-Tac-Toe!'
      expect(cli).to receive(:put_string).with(expected_message).once

      tic_tac_toe = TicTacToe.new(cli)
      tic_tac_toe.print_welcome
    end
  end
end
