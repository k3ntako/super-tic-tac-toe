require_relative '../../lib/game'

RSpec.describe Game do
  let(:ui) do
    cli = CLI.new
    UserInterface.new(cli)
  end
  let(:game_messenger) { GameMessenger.new(ui) }
  let(:game) do
    game_args = {
      game_messenger: game_messenger,
      board: Board.new,
      game_end_evaluator: GameEndEvaluator.new,
      player_one: Player.new(ui, 'X'),
      player_two: Player.new(ui, 'O')
    }

    Game.new(game_args)
  end

  describe 'start' do
    it 'should alternate players' do
      player_one = game.instance_variable_get(:@current_player)
      player_two = game.instance_variable_get(:@previous_player)

      allow(game_messenger).to receive(:display_board)
      allow(game_messenger).to receive(:display_move_instruction)

      expect(player_one).to receive(:get_move).once.ordered.and_return 1
      expect(player_two).to receive(:get_move).once.ordered.and_return 2
      expect(player_one).to receive(:get_move).once.ordered.and_return 4
      expect(player_two).to receive(:get_move).once.ordered.and_return 5
      expect(player_one).to receive(:get_move).once.ordered.and_return 7

      allow(game_messenger).to receive(:display_game_over_with_winner)

      game.start
    end

    context 'when a game ends in a tie' do
      it 'should call display_game_over_with_tie' do
        board = Board.new
        played_board_state = [
          ['O', 'X', 'O'],
          ['X', 'X', 'O'],
          ['X', 'O', nil]
        ]

        board.instance_variable_set(:@board, played_board_state)
        game.instance_variable_set(:@board, board)

        player_one = game.instance_variable_get(:@current_player)

        expect(game_messenger).to receive(:display_board).twice
        expect(game_messenger).to receive(:display_move_instruction).once
        expect(player_one).to receive(:get_move).once.ordered.and_return 9

        expect(game_messenger).to receive(:display_game_over_with_tie).once.ordered

        game.start
      end
    end

    context 'when a user wins' do
      it 'should call display_game_over_with_winner' do
        board = Board.new
        played_board_state = [
          ['O', 'X', nil],
          [nil, 'X', 'O'],
          ['X', 'O', nil]
        ]

        board.instance_variable_set(:@board, played_board_state)
        game.instance_variable_set(:@board, board)

        player_one = game.instance_variable_get(:@current_player)

        expect(game_messenger).to receive(:display_board).twice
        expect(game_messenger).to receive(:display_move_instruction).once
        expect(player_one).to receive(:get_move).once.ordered.and_return 3

        expect(game_messenger).to receive(:display_game_over_with_winner).once.ordered.with player_one

        game.start
      end
    end
  end
end
