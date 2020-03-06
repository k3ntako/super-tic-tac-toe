require_relative '../../lib/user_interface'
require_relative '../../lib/board'
require_relative '../../lib/tic_tac_toe'

class MockGame
  attr_reader :triggered_actions, :players

  def initialize(game_state: nil, players:)
    @game_state = game_state
    @players = players
    @triggered_actions = []
  end

  def start
    @triggered_actions.push('start')
  end
end

class MockGameGenerator
  attr_reader :triggered_actions, :last_game_created
  def initialize
    @triggered_actions = []
    @last_game_created = nil
  end

  def create_a_game(user_interface:, opponent:)
    @triggered_actions.push('create_a_game')

    @last_game_created = MockGame.new(players: [:human, opponent])
    @last_game_created
  end
end

RSpec.describe TicTacToe do
  let(:mock_cli) { TestCLI.new }
  let(:ui) { UserInterface.new mock_cli }
  let(:mock_game_generator) { MockGameGenerator.new }
  let(:tic_tac_toe) { TicTacToe.new(user_interface: ui, game_generator: mock_game_generator) }

  describe 'start' do
    it 'should clear output' do
      tic_tac_toe.start

      expect(mock_cli.triggered_actions[0]).to eq 'clear_output'
    end

    it 'should display welcome, instructions, the board, and prompt a move' do
      tic_tac_toe.start

      expect(mock_game_generator.triggered_actions[0]).to eq 'create_a_game'
    end

    it 'should ask user if they would like to play a computer or a human' do
      tic_tac_toe.start

      expect(mock_cli.triggered_actions[2]).to eq 'display_empty_line'
      expect(mock_cli.displayed_messages[1]).to eq 'Would you like to play a human or a computer?'
      expect(mock_cli.displayed_messages[2]).to eq 'Enter 1 for human, and 2 for computer:'
    end

    it 'should ask user if they would like to play a computer or a human' do
      tic_tac_toe.start

      expect(mock_cli.triggered_actions[5]).to eq 'get_user_input'
    end

    it 'should create a game with two human if user picks human as the opponent' do
      mock_cli.fake_user_inputs.push '1'

      tic_tac_toe.start

      expect(mock_game_generator.triggered_actions[0]).to eq 'create_a_game'
      mock_game = mock_game_generator.last_game_created

      expect(mock_game.players).to eq %i[human human]
    end

    it 'should create a game with computer if user picks computer as the opponent' do
      mock_cli.fake_user_inputs.push '2'

      tic_tac_toe.start

      expect(mock_game_generator.triggered_actions[0]).to eq 'create_a_game'
      mock_game = mock_game_generator.last_game_created

      expect(mock_game.players).to eq %i[human computer]
    end
  end
end
