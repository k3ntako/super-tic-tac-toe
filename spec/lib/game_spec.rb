require_relative '../../lib/game'

RSpec.describe Game do
  let(:ui) do
    cli = CLI.new
    UserInterface.new(cli)
  end
  let(:game_messenger) do
    GameMessenger.new(
      user_interface: ui,
      message_generator: GameMessage.new
    )
  end
  let(:players) { [HumanPlayer.new(ui, 'X', InputValidator.new), HumanPlayer.new(ui, 'O', InputValidator.new)] }
  let(:game_state) do
    GameState.new(
      game_messenger: game_messenger,
      game_end_evaluator: GameEndEvaluator.new,
      board: Board.new(width: 3),
      players: players
    )
  end

  let(:game) do
    Game.new(
      game_state: game_state
    )
  end

  describe 'start' do
    it 'should go through the loop and exit with a tie' do
      # loop
      expect(game_state).to receive(:game_over?).ordered.and_return false
      expect(game_state).to receive(:display_board_with_messages_for_move).ordered
      expect(game_state).to receive(:player_move).ordered
      expect(game_state).to receive(:alternate_current_player).ordered

      expect(game_state).to receive(:game_over?).ordered.and_return true

      # exit game
      expect(game_state).to receive(:player_won?).ordered.and_return false

      expect(game_state).to receive(:display_board_with_messages).ordered.with(
        bottom_messages: [[:game_over, { winner: nil }]]
      )

      game.play
    end

    it 'should let user know that X won' do
      board_with_winner = [
        ['X', 'X', 'X'],
        [nil, nil, nil],
        ['O', 'O', nil]
      ]

      board = Board.new(width: 3)
      board.instance_variable_set(:@state, board_with_winner)
      game_state.instance_variable_set(:@board, board)
      game_state.instance_variable_set(:@current_player_idx, 1)

      # loop
      allow(game_state).to receive(:game_over?).and_return(true)

      # exit game
      expect(game_messenger).to receive(:display).ordered.with(
        message: :match_up,
        params: { players: players }
      )
      expect(game_messenger).to receive(:display_board).ordered
      expect(game_messenger).to receive(:display).with(message: :game_over, params: { winner: 'X' })

      game.play
    end
  end
end
