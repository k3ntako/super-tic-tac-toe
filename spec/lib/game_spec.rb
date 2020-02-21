require_relative '../../lib/game'

RSpec.describe Game do
  let(:game) do
    cli = CLI.new
    ui = UserInterface.new(cli)
    board = Board.new
    player = Player.new(ui, 'X')

    Game.new(board, player)
  end

  describe 'start' do
    it 'should display welcome, instructions, the board, and prompt a move' do
      pos_str = '2'

      player_one = game.instance_variable_get(:@player_one)

      board = spy('board')
      game.instance_variable_set(:@board, board)

      expect(game).to receive(:display_board).once.ordered
      expect(game).to receive(:display_move_instruction).ordered

      expect(player_one).to receive(:get_move).and_return(pos_str).ordered

      expect(game).to receive(:display_board).once.ordered

      game.start
    end
  end
end
