require_relative '../../lib/player'
require_relative '../../lib/game_state'
require_relative '../../lib/user_input_validator'

RSpec.describe GameState do
  let(:ui) do
    cli = CLI.new
    UserInterface.new(cli)
  end
  let(:game_messenger) { GameMessenger.new(ui) }
  let(:game_state) do
    players = [
      Player.new(ui, 'X'),
      Player.new(ui, 'O')
    ]

    GameState.new(
      game_end_evaluator: GameEndEvaluator.new,
      user_input_validator: UserInputValidator.new,
      game_messenger: game_messenger,
      board: Board.new,
      players: players
    )
  end

  describe 'alternate_current_player' do
    it 'should alternate the index (0 vs. 1)' do
      intial_idx = game_state.instance_variable_get(:@current_player_idx)
      expect(intial_idx).to eq(0)

      game_state.alternate_current_player

      idx_after_alternating = game_state.instance_variable_get(:@current_player_idx)
      expect(idx_after_alternating).to eq(1)

      game_state.alternate_current_player

      idx_after_alternating_twice = game_state.instance_variable_get(:@current_player_idx)
      expect(idx_after_alternating_twice).to eq(0)
    end
  end

  describe 'make_move' do
    context 'when the move is valid' do
      it 'should call update board based on current_players input' do
        current_player_idx = game_state.instance_variable_get(:@current_player_idx)
        players = game_state.instance_variable_get(:@players)
        player_one = players[current_player_idx]

        board = game_state.instance_variable_get(:@board)

        user_input_validator = game_state.instance_variable_get(:@user_input_validator)
        allow(user_input_validator).to receive(:move_valid_integer?).and_return true
        allow(user_input_validator).to receive(:move_on_empty_square?).and_return true

        pos_str = '9'
        expect(player_one).to receive(:get_move).and_return pos_str
        expect(board).to receive(:update).with(player_one.mark, pos_str)

        game_state.make_move
      end
    end

    context 'when the move is not a valid integer' do
      it 'should ask user to try again' do
        current_player_idx = game_state.instance_variable_get(:@current_player_idx)
        players = game_state.instance_variable_get(:@players)
        player_one = players[current_player_idx]

        board = game_state.instance_variable_get(:@board)

        user_input_validator = game_state.instance_variable_get(:@user_input_validator)
        allow(user_input_validator).to receive(:move_valid_integer?).and_return(false, true)
        allow(user_input_validator).to receive(:move_on_empty_square?).and_return(true)

        invalid_pos_str = 'abc'
        pos_str = '9'
        expect(player_one).to receive(:get_move).and_return(invalid_pos_str, pos_str)
        expect(board).to receive(:update).with(player_one.mark, pos_str)

        expect(game_messenger).to receive(:display_not_valid_integer).once

        game_state.make_move
      end
    end

    context 'when making a move on a square that is taken' do
      it 'should ask user to try again' do
        current_player_idx = game_state.instance_variable_get(:@current_player_idx)
        players = game_state.instance_variable_get(:@players)
        player_one = players[current_player_idx]

        board = game_state.instance_variable_get(:@board)

        user_input_validator = game_state.instance_variable_get(:@user_input_validator)
        allow(user_input_validator).to receive(:move_valid_integer?).and_return(true)
        allow(user_input_validator).to receive(:move_on_empty_square?).and_return(false, true)

        invalid_pos_str = '1'
        pos_str = '9'
        expect(player_one).to receive(:get_move).and_return(invalid_pos_str, pos_str)
        expect(board).to receive(:update).with(player_one.mark, pos_str)

        expect(game_messenger).to receive(:display_square_taken).once

        game_state.make_move
      end
    end
  end

  describe 'previous_player' do
    it 'should return the player that is not currently active' do
      player = game_state.previous_player
      expect(player.mark).to eq('O')
    end

    it 'should return the other player when alternate_current_player is called' do
      game_state.alternate_current_player
      player = game_state.previous_player

      expect(player.mark).to eq('X')
    end
  end
end
