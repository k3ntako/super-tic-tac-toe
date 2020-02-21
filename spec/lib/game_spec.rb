require_relative '../../lib/game'

RSpec.describe Game do
  let(:game) do
    cli = CLI.new
    ui = UserInterface.new(cli)
    board = Board.new
    player_one = Player.new(ui, 'X')
    player_two = Player.new(ui, 'O')

    Game.new(ui, board, player_one, player_two)
  end

  describe 'start' do
    it 'should display board and call one_turn' do
      expect(game).to receive(:display_board).once.ordered
      expect(game).to receive(:one_turn).once.ordered

      game.start
    end
  end
end
