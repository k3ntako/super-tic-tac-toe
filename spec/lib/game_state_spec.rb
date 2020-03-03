require_relative '../../lib/player'
require_relative '../../lib/game_state'
require_relative '../../lib/move_validator'

class TestCLI
  attr_reader :diplayed_messages, :triggered_actions
  def initialize
    @diplayed_messages = []
    @triggered_actions = []
  end

  def display_message(message)
    @diplayed_messages.push message
    @triggered_actions.push 'display_message'

    nil
  end

  def display_board(board_state)
    return nil unless board_state.is_a? Array

    board_str = board_state.flatten.map { |square| square || 'nil' }

    @triggered_actions.push 'display_board'

    display_message board_str.join(',')
  end

  def clear_output
    @triggered_actions.push 'clear_output'

    true
  end
end

MESSAGES = {
  welcome: 'Welcome to a game of Tic-Tac-Toe!',
  title: 'Super TicTacToe',
  move_instruction_x: 'Enter a number to make a move in the corresponding square (X\'s turn):',
  move_instruction_o: 'Enter a number to make a move in the corresponding square (O\'s turn):',
  game_over_X_wins: 'Game Over: X Wins',
  game_over_O_wins: 'Game Over: O Wins',
  game_over_with_tie: 'Game Over: Tie!',
  not_valid_integer: 'Make sure it\'s an integer and try again!',
  square_unavailable: 'You can\'t make a move there, try again!'
}.freeze

RSpec.describe GameState do
  let(:ui) { UserInterface.new(TestCLI.new) }
  let(:game_messenger) { GameMessenger.new(user_interface: ui, messages: MESSAGES) }
  let(:board) { Board.new }
  let(:game_state) do
    players = [
      Player.new(ui, 'X'),
      Player.new(ui, 'O')
    ]

    move_validator = MoveValidator.new(game_messenger: game_messenger)

    GameState.new(
      game_messenger: game_messenger,
      game_end_evaluator: GameEndEvaluator.new,
      move_validator: move_validator,
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

      move_validator = game_state.instance_variable_get(:@move_validator)
      allow(move_validator).to receive(:error_for_integer).and_return nil
      allow(move_validator).to receive(:error_for_square).and_return nil

      pos_str = '9'
      expect(player_one).to receive(:get_move).and_return pos_str
      expect(board).to receive(:update).with(player_one.mark, pos_str)

      game_state.player_move
    end

    it 'should ask user to try again when move is not a valid integer' do
      current_player_idx = game_state.instance_variable_get(:@current_player_idx)
      players = game_state.instance_variable_get(:@players)
      player_one = players[current_player_idx]

      move_validator = game_state.instance_variable_get(:@move_validator)
      allow(move_validator).to receive(:error_for_integer).and_return(:not_valid_integer, nil)
      allow(move_validator).to receive(:error_for_square).and_return(nil)

      allow(game_state).to receive(:display_board_with_messages)

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

      move_validator = game_state.instance_variable_get(:@move_validator)
      allow(move_validator).to receive(:error_for_integer).and_return(nil)
      allow(move_validator).to receive(:error_for_square).and_return(:square_unavailable, nil)

      allow(game_state).to receive(:display_board_with_messages)

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

  describe 'display_board_with_messages' do
    let(:test_cli) do
      game_state.display_board_with_messages(
        top_message: :welcome,
        bottom_messages: [:move_instruction_o]
      )

      ui.instance_variable_get(:@platform)
    end

    it 'should print clear output first' do
      expect(test_cli.triggered_actions[0]).to eq 'clear_output'
    end

    it 'should print the top message' do
      expect(test_cli.triggered_actions[1]).to eq 'display_message'
      expect(test_cli.diplayed_messages[0]).to eq 'Welcome to a game of Tic-Tac-Toe!'
    end

    it 'should print the board' do
      expect(test_cli.triggered_actions[2]).to eq 'display_board'
      expect(test_cli.triggered_actions[3]).to eq 'display_message'
      expect(test_cli.diplayed_messages[1]).to eq 'nil,nil,nil,nil,nil,nil,nil,nil,nil'
    end

    it 'should print the bottom message' do
      expect(test_cli.triggered_actions[4]).to eq 'display_message'
      expect(test_cli.diplayed_messages[2]).to eq(
        'Enter a number to make a move in the corresponding square (O\'s turn):'
      )
    end
  end
end
