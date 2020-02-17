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

  context 'when display_board is called' do
    it 'should print the board to console' do
      board_instance = tic_tac_toe.instance_variable_get(:@board)
      board_state = board_instance.board

      expect(ui).to receive(:display_board).with(board_state).once

      tic_tac_toe.display_board
    end
  end

  context 'when start is called' do
    it 'should display welcome, instructions,the board, and prompt a move' do
      expect(tic_tac_toe).to receive(:display_welcome)

      position_str = '2'

      board = spy('board')
      tic_tac_toe.instance_variable_set(:@board, board)

      expect(tic_tac_toe).to receive(:display_move_instruction)
      expect(tic_tac_toe).to receive(:display_board).twice
      expect(tic_tac_toe).to receive(:prompt_move).and_return(position_str)
      expect(board).to receive(:make_move).with('X', position_str)

      tic_tac_toe.start
    end
  end

  context 'when prompt_move is called' do
    it 'should call UserInterface#prompt_user_input and receive the input' do
      input_text = 'input text'
      allow_any_instance_of(Kernel).to receive(:gets).and_return(input_text)

      user_move = tic_tac_toe.prompt_move

      expect(user_move).to eql input_text
    end
  end
end
