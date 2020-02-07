# frozen_string_literal: true

require_relative '../../lib/user_interface'
require_relative '../../lib/cli'
require_relative '../../lib/board'
require_relative '../../lib/tic_tac_toe'

RSpec.describe 'TicTacToe' do
  let(:ui) do
    cli = CLI.new
    UserInterface.new cli
  end
  let(:tic_tac_toe) { TicTacToe.new(ui) }

  context 'when TicTacToe is initialized' do
    it 'should have instances of CLI and Board as instance variables' do
      # Allows access to private instance variable
      private_ui = tic_tac_toe.instance_variable_get(:@user_interface)
      expect(private_ui).to be_kind_of UserInterface

      private_board = tic_tac_toe.instance_variable_get(:@board)
      expect(private_board).to be_kind_of Board
    end
  end

  context 'when display_welcome is called' do
    it 'should print a welcome message' do
      expected_message = 'Welcome to a game of Tic-Tac-Toe!'
      expect(ui).to receive(:display_message).with(expected_message).once

      tic_tac_toe.display_welcome
    end
  end

  context 'when display_board is called' do
    it 'should print the board to console' do
      board_instance = tic_tac_toe.instance_variable_get(:@board)
      board_state = board_instance.board

      expect(ui).to receive(:display_board).with(board_state).once

      tic_tac_toe.display_board
    end
  end

  context 'when start is called' do
    it 'should call display_welcome and display_board' do
      expect(tic_tac_toe).to receive(:display_welcome)
      expect(tic_tac_toe).to receive(:display_board)

      tic_tac_toe.start
    end
  end
end
