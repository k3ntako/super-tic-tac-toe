require_relative '../../lib/user_interface'
require_relative '../../lib/cli'
require_relative '../../lib/board'
require_relative '../../lib/tic_tac_toe'

RSpec.describe TicTacToe do
  let(:ui) do
    cli = CLI.new
    UserInterface.new cli
  end

  let(:tic_tac_toe) { TicTacToe.new(ui) }

  describe 'initialize' do
    it 'should have instances of CLI and Board as instance variables' do
      # Allows access to private instance variable
      private_ui = tic_tac_toe.instance_variable_get(:@user_interface)
      expect(private_ui).to be_kind_of UserInterface
    end
  end

  describe 'start' do
    it 'should display welcome, instructions, the board, and prompt a move' do
      game_spy = spy('game')

      expect(tic_tac_toe).to receive(:create_a_game).once.ordered.and_return(game_spy)
      expect(game_spy).to receive(:start).once.ordered

      tic_tac_toe.start
    end
  end
end
