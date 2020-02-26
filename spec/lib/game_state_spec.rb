require_relative '../../lib/player'
require_relative '../../lib/game_state'

RSpec.describe GameState do
  let(:game_state) do
    cli = CLI.new
    ui = UserInterface.new(cli)

    players = [
      Player.new(ui, 'X'),
      Player.new(ui, 'O')
    ]

    GameState.new(
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
    it 'should call update board based on current_players input' do
      current_player_idx = game_state.instance_variable_get(:@current_player_idx)
      players = game_state.instance_variable_get(:@players)
      player_one = players[current_player_idx]

      board = game_state.instance_variable_get(:@board)

      pos_str = '9'
      expect(player_one).to receive(:get_move).and_return pos_str
      expect(board).to receive(:update).with(player_one.mark, pos_str)

      game_state.make_move
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
