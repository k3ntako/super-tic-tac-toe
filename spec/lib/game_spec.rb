require_relative '../../lib/game'

RSpec.describe Game do
  let(:ui) do
    cli = CLI.new
    UserInterface.new(cli)
  end
  let(:game_messenger) { GameMessenger.new(user_interface: ui) }
  let(:game_state) do
    players = [
      Player.new(ui, 'X'),
      Player.new(ui, 'O')
    ]

    GameState.new(
      game_end_evaluator: GameEndEvaluator.new,
      board: Board.new,
      players: players
    )
  end

  let(:game) do
    Game.new(
      game_messenger: game_messenger,
      game_state: game_state
    )
  end

  describe 'start' do
    it 'should go through the loop and exit with a tie' do
      expect(game_messenger).to receive(:display_board).with(game_state.board).ordered

      # loop
      expect(game_state).to receive(:game_over?).ordered.and_return false
      expect(game_messenger).to receive(:display).ordered.with(message: :move_instruction)
      expect(game_state).to receive(:player_move).ordered
      expect(game_messenger).to receive(:display_board).with(game_state.board).ordered
      expect(game_state).to receive(:game_over?).ordered.and_return true

      # exit game
      expect(game_messenger).to receive(:display).ordered.with(message: :game_over_with_tie)

      game.start
    end

    it 'should let user know that X won' do
      board_with_winner = [
        ['X', 'X', 'X'],
        [nil, nil, nil],
        ['O', 'O', nil]
      ]

      board = Board.new
      board.instance_variable_set(:@board, board_with_winner)
      game_state.instance_variable_set(:@board, board)
      game_state.instance_variable_set(:@current_player_idx, 1)

      allow(game_messenger).to receive(:display_board)

      # loop
      allow(game_state).to receive(:game_over?).and_return(true)

      # exit game
      expect(game_messenger).to receive(:display).with(message: :game_over_X_wins)

      game.start
    end
  end
end
