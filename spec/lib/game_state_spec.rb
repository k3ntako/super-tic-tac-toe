require_relative '../../lib/human_player'
require_relative '../../lib/game_state'
require_relative '../../lib/input_validator'
require_relative './mock_classes/cli_mock'

RSpec.describe GameState do
  let(:mock_cli) { TestCLI.new }
  let(:ui) { UserInterface.new(mock_cli) }
  let(:game_messenger) { GameMessenger.new(user_interface: ui, message_generator: GameMessage.new) }
  let(:board) { Board.new(width: 3) }
  let(:input_validator) { InputValidator.new }
  let(:players) { [HumanPlayer.new(ui, 'X', InputValidator.new), HumanPlayer.new(ui, 'O', InputValidator.new)] }
  let(:game_state) do
    GameState.new(
      game_messenger: game_messenger,
      game_end_evaluator: GameEndEvaluator.new,
      board: board,
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

      allow(input_validator).to receive(:input_error).and_return nil
      allow(input_validator).to receive(:position_error).and_return nil

      mock_cli.fake_user_inputs = ['1']
      expect(board).to receive(:update).with(player_one.mark, '1')

      game_state.player_move
    end

    it 'should ask user to try again when move is not a valid integer' do
      current_player_idx = game_state.instance_variable_get(:@current_player_idx)
      players = game_state.instance_variable_get(:@players)
      player_one = players[current_player_idx]

      allow(input_validator).to receive(:input_error).and_return(:not_valid_integer, nil)
      allow(input_validator).to receive(:position_error).and_return(nil)

      allow(game_state).to receive(:display_board_with_messages)

      mock_cli.fake_user_inputs = ['abc', '5']
      expect(board).to receive(:update).with(player_one.mark, '5')

      game_state.player_move
    end

    it 'should ask user to try again if the square is already taken' do
      current_player_idx = game_state.instance_variable_get(:@current_player_idx)
      players = game_state.instance_variable_get(:@players)
      player_one = players[current_player_idx]

      allow(input_validator).to receive(:input_error).and_return(nil)
      allow(input_validator).to receive(:position_error).and_return(:square_unavailable, nil)

      allow(game_state).to receive(:display_board_with_messages)

      board.instance_variable_set(:@board, [
                                    ['X', nil, nil],
                                    [nil, nil, nil],
                                    [nil, nil, nil]
                                  ])

      mock_cli.fake_user_inputs = ['1', '9']
      expect(board).to receive(:update).with(player_one.mark, '9')

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

  describe 'display_board_with_messages' do
    let(:test_cli) do
      game_state.display_board_with_messages(
        top_message: [:welcome],
        bottom_messages: [[:move_instruction, { current_player: 'O' }]]
      )

      ui.instance_variable_get(:@platform)
    end

    it 'should print clear output first' do
      expect(test_cli.triggered_actions[0]).to eq 'clear_output'
    end

    it 'should print the top message' do
      expect(test_cli.triggered_actions[1]).to eq 'display_message'
      expect(test_cli.displayed_messages[0]).to eq 'Welcome to a game of Tic-Tac-Toe!'
    end

    it 'should print the board' do
      expect(test_cli.triggered_actions[2]).to eq 'display_board'
      expect(test_cli.triggered_actions[3]).to eq 'display_message'
      expect(test_cli.displayed_messages[1]).to eq 'nil,nil,nil,nil,nil,nil,nil,nil,nil'
    end

    it 'should print the bottom message' do
      expect(test_cli.triggered_actions[4]).to eq 'display_message'
      expect(test_cli.displayed_messages[2]).to eq(
        'Enter a number to make a move in the corresponding square (O\'s turn):'
      )
    end
  end

  describe 'display_board_with_messages_for_move' do
    it 'should add instruction to bottom message' do
      expect(game_messenger).to receive(:display_board_with_messages).with(
        top_message: :test,
        board: board,
        bottom_messages: [[:second_test], [:move_instruction, { current_player: 'X' }]]
      )

      game_state.display_board_with_messages_for_move(top_message: :test, bottom_messages: [[:second_test]])
    end

    it 'should display the appropriate instructions based on the current played index' do
      game_state.instance_variable_set(:@current_player_idx, 1)
      expect(game_messenger).to receive(:display_board_with_messages).with(
        top_message: :test,
        board: board,
        bottom_messages: [[:second_test], [:move_instruction, { current_player: 'O' }]]
      )

      game_state.display_board_with_messages_for_move(top_message: :test, bottom_messages: [[:second_test]])
    end

    it 'should display default messages if nothing is passed in' do
      game_state.instance_variable_set(:@current_player_idx, 1)
      expect(game_messenger).to receive(:display_board_with_messages).with(
        top_message: [:match_up, { players: players }],
        board: board,
        bottom_messages: [[:move_instruction, { current_player: 'O' }]]
      )

      game_state.display_board_with_messages_for_move
    end
  end
end
