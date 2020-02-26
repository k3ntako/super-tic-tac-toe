require_relative '../../lib/game'

RSpec.describe Game do
  let(:ui) do
    cli = CLI.new
    UserInterface.new(cli)
  end
  let(:game_messenger) { GameMessenger.new(ui) }
  let(:game_end_evaluator) { GameEndEvaluator.new }
  let(:game_state) do
    players = [
      Player.new(ui, 'X'),
      Player.new(ui, 'O')
    ]

    GameState.new(
      board: Board.new,
      players: players
    )
  end

  let(:game) do
    Game.new(
      game_messenger: game_messenger,
      game_end_evaluator: game_end_evaluator,
      game_state: game_state
    )
  end

  describe 'start' do
    it 'should go through the loop and exit with a tie' do
      expect(game_messenger).to receive(:display_board).with(game_state.board).ordered

      # loop
      expect(game_end_evaluator).to receive(:game_over?).with(game_state.board).ordered.and_return false
      expect(game_messenger).to receive(:display_move_instruction).ordered
      expect(game_state).to receive(:make_move).ordered
      expect(game_messenger).to receive(:display_board).with(game_state.board).ordered
      expect(game_end_evaluator).to receive(:game_over?).ordered.and_return true

      # exit game
      expect(game_messenger).to receive(:display_game_over_with_tie).ordered

      game.start
    end

    context 'when a player wins' do
      it 'should call display_game_over_with_tie' do
        board_with_winner = [
          ['X', 'X', 'X'],
          [nil, nil, nil],
          ['O', 'O', nil]
        ]

        board = Board.new
        board.instance_variable_set(:@board, board_with_winner)
        game_state.instance_variable_set(:@board, board)

        allow(game_messenger).to receive(:display_board)

        # loop
        allow(game_end_evaluator).to receive(:game_over?).and_return(true)

        # exit game
        expect(game_messenger).to receive(:display_game_over_with_winner)

        game.start
      end
    end
  end
end
