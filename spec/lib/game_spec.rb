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
    context 'when a game ends in a tie' do
      it 'should call exit_game_with_tie' do
        player_one = game.instance_variable_get(:@current_player)
        player_two = game.instance_variable_get(:@previous_player)

        expect(game).to receive(:display_board).exactly(10).times
        expect(game).to receive(:display_move_instruction).exactly(9).times

        expect(player_one).to receive(:get_move).once.ordered.and_return 5
        expect(player_two).to receive(:get_move).once.ordered.and_return 1
        expect(player_one).to receive(:get_move).once.ordered.and_return 7
        expect(player_two).to receive(:get_move).once.ordered.and_return 3
        expect(player_one).to receive(:get_move).once.ordered.and_return 2
        expect(player_two).to receive(:get_move).once.ordered.and_return 8
        expect(player_one).to receive(:get_move).once.ordered.and_return 4
        expect(player_two).to receive(:get_move).once.ordered.and_return 6
        expect(player_one).to receive(:get_move).once.ordered.and_return 9

        expect(game).to receive(:exit_game_with_tie).once.ordered

        game.start
      end
    end

    context 'when a user wins' do
      it 'should call exit_game_with_winner' do
        player_one = game.instance_variable_get(:@current_player)
        player_two = game.instance_variable_get(:@previous_player)

        expect(game).to receive(:display_board).exactly(6).times
        expect(game).to receive(:display_move_instruction).exactly(5).times

        expect(player_one).to receive(:get_move).once.ordered.and_return 5
        expect(player_two).to receive(:get_move).once.ordered.and_return 1
        expect(player_one).to receive(:get_move).once.ordered.and_return 2
        expect(player_two).to receive(:get_move).once.ordered.and_return 1
        expect(player_one).to receive(:get_move).once.ordered.and_return 8

        expect(game).to receive(:exit_game_with_winner).once.ordered.with player_one

        game.start
      end
    end
  end
end
