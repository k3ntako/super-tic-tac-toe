require_relative '../../lib/game'

RSpec.describe Game do
  let(:ui) do
    cli = CLI.new
    UserInterface.new(cli)
  end
  let(:game_messenger) do
    GameMessenger.new(
      user_interface: ui,
      game_message_generator: GameMessageGenerator.new
    )
  end
  let(:game_state) do
    players = [
      Player.new(ui, 'X'),
      Player.new(ui, 'O')
    ]

    GameState.new(
      game_messenger: game_messenger,
      game_end_evaluator: GameEndEvaluator.new,
      move_validator: MoveValidator.new,
      board: Board.new,
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
      expect(game_state).to receive(:display_board_with_messages_for_move).ordered

      # loop
      expect(game_state).to receive(:game_over?).ordered.and_return false
      expect(game_state).to receive(:player_move).ordered
      expect(game_state).to receive(:alternate_current_player).ordered
      expect(game_state).to receive(:display_board_with_messages_for_move).ordered

      expect(game_state).to receive(:game_over?).ordered.and_return true

      # exit game
      expect(game_state).to receive(:player_won?).ordered.and_return false

      expect(game_state).to receive(:display_board_with_messages).ordered.with(
        bottom_messages: [[:game_over, { winner: nil }]]
      )

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

      expect(game_state).to receive(:display_board_with_messages_for_move).ordered

      # loop
      allow(game_state).to receive(:game_over?).and_return(true)

      # exit game
      expect(game_messenger).to receive(:display).ordered.with(message: :welcome, params: nil)
      expect(game_messenger).to receive(:display_board).ordered
      expect(game_messenger).to receive(:display).with(message: :game_over, params: { winner: 'X' })

      game.start
    end
  end
end
