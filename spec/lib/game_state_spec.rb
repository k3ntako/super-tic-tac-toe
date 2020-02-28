require_relative '../../lib/player'
require_relative '../../lib/game_state'
require_relative '../../lib/move_validator'

RSpec.describe GameState do
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

    move_validator = MoveValidator.new(game_messenger: game_messenger)

    GameState.new(
      game_end_evaluator: GameEndEvaluator.new,
      move_validator: move_validator,
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

  describe 'player_move' do
    it 'should call update board based on current_players input when move is valid' do
      current_player_idx = game_state.instance_variable_get(:@current_player_idx)
      players = game_state.instance_variable_get(:@players)
      player_one = players[current_player_idx]

      board = game_state.instance_variable_get(:@board)

      move_validator = game_state.instance_variable_get(:@move_validator)
      allow(move_validator).to receive(:valid_integer?).and_return true
      allow(move_validator).to receive(:empty_square?).and_return true

      pos_str = '9'
      expect(player_one).to receive(:get_move).and_return pos_str
      expect(board).to receive(:update).with(player_one.mark, pos_str)

      game_state.player_move
    end

    it 'should ask user to try again when move is not a valid integer' do
      current_player_idx = game_state.instance_variable_get(:@current_player_idx)
      players = game_state.instance_variable_get(:@players)
      player_one = players[current_player_idx]

      board = game_state.instance_variable_get(:@board)

      move_validator = game_state.instance_variable_get(:@move_validator)
      allow(move_validator).to receive(:valid_integer?).and_return(false, true)
      allow(move_validator).to receive(:empty_square?).and_return(true)

      invalid_pos_str = 'abc'
      pos_str = '9'
      expect(player_one).to receive(:get_move).and_return(invalid_pos_str, pos_str)
      expect(board).to receive(:update).with(player_one.mark, pos_str)

      game_state.player_move
    end

    it 'should ask user to try again if the square is already taken' do
      current_player_idx = game_state.instance_variable_get(:@current_player_idx)
      players = game_state.instance_variable_get(:@players)
      player_one = players[current_player_idx]

      board = game_state.instance_variable_get(:@board)

      move_validator = game_state.instance_variable_get(:@move_validator)
      allow(move_validator).to receive(:valid_integer?).and_return(true)
      allow(move_validator).to receive(:empty_square?).and_return(false, true)

      invalid_pos_str = '1'
      pos_str = '9'
      expect(player_one).to receive(:get_move).and_return(invalid_pos_str, pos_str)
      expect(board).to receive(:update).with(player_one.mark, pos_str)

      game_state.player_move
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
