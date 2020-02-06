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

  context 'when print_board is called' do
    it 'should print the board to console' do
      expected_output = 'This is the expected string'

      expect(cli).to receive(:put_string).with(expected_output).once

      tic_tac_toe = TicTacToe.new(cli)
      # @board.to_s returns the expected_output instead of the board from @board
      board_double = double('board_double', to_s: expected_output)
      tic_tac_toe.instance_variable_set(:@board, board_double)

      tic_tac_toe.print_board
    end
  end

  context 'when start is called' do
    it 'should call print_welcome and print_board' do
      tic_tac_toe = TicTacToe.new(cli)

      expect(tic_tac_toe).to receive(:print_welcome)
      expect(tic_tac_toe).to receive(:print_board)

      tic_tac_toe.start
    end
  end
end
