require_relative '../../lib/user_interface'
require_relative '../../lib/cli'
require_relative '../../lib/board'
require_relative '../../lib/tic_tac_toe'

RSpec.describe TicTacToe do
  let(:ui) do
    cli = CLI.new
    UserInterface.new cli
  end

  let(:tic_tac_toe) do
    board = Board.new
    player = Player.new(ui, 'X')

    TicTacToe.new(ui, board, player)
  end

  describe 'initialize' do
    it 'should have instances of CLI and Board as instance variables' do
      # Allows access to private instance variable
      private_ui = tic_tac_toe.instance_variable_get(:@user_interface)
      expect(private_ui).to be_kind_of UserInterface

      private_board = tic_tac_toe.instance_variable_get(:@board)
      expect(private_board).to be_kind_of Board
    end
  end

  describe 'start' do
    it 'should display welcome, instructions,the board, and prompt a move' do
      pos_str = '2'

      player_one = tic_tac_toe.instance_variable_get(:@player_one)

      board = spy('board')
      tic_tac_toe.instance_variable_set(:@board, board)

      expect(tic_tac_toe).to receive(:display_welcome).once.ordered
      expect(tic_tac_toe).to receive(:display_board).once.ordered
      expect(tic_tac_toe).to receive(:display_move_instruction).ordered
      expect(player_one).to receive(:get_move).and_return(pos_str).ordered
      expect(player_one).to receive(:make_move).with(board, pos_str).ordered
      expect(tic_tac_toe).to receive(:display_board).once.ordered

      tic_tac_toe.start
    end
  end
end
