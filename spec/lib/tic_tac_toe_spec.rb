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
  let(:tic_tac_toe) do
    TicTacToe.new(
      user_interface: ui,
      game_generator: mock_game_generator,
      input_validator: InputValidator.new
    )
  end

  describe 'start' do
    it 'should clear output' do
      allow(tic_tac_toe).to receive(:get_opponent_selection).and_return(:human)

      tic_tac_toe.start

      expect(mock_cli.triggered_actions[0]).to eq 'clear_output'
    end

    it 'should display welcome, instructions, the board, and prompt a move' do
      allow(tic_tac_toe).to receive(:get_opponent_selection).and_return(:computer)

      tic_tac_toe.start

      expect(mock_game_generator.triggered_actions[0]).to eq 'create_a_game'
    end

    it 'should ask user if they would like to play a computer or a human' do
      mock_cli.fake_user_inputs = ['1']

      tic_tac_toe.start

      expect(mock_cli.triggered_actions[2]).to eq 'display_empty_line'
      expect(mock_cli.displayed_messages[2]).to eq 'Would you like to play a human or a computer?'
      expect(mock_cli.displayed_messages[3]).to eq 'Enter 1 for human, and 2 for computer:'
    end

    it 'should ask user if they would like to play a computer or a human' do
      mock_cli.fake_user_inputs = ['2']

      tic_tac_toe.start

      expect(mock_cli.triggered_actions[6]).to eq 'get_user_input'
    end

    it 'should create a game with two human if user picks human as the opponent' do
      mock_cli.fake_user_inputs = ['1']

      tic_tac_toe.start

      expect(mock_game_generator.triggered_actions[0]).to eq 'create_a_game'
      mock_game = mock_game_generator.last_game_created

      expect(mock_game.players).to eq %i[human human]
    end

    it 'should create a game with computer if user picks computer as the opponent' do
      mock_cli.fake_user_inputs = ['2']

      tic_tac_toe.start

      expect(mock_game_generator.triggered_actions[0]).to eq 'create_a_game'
      mock_game = mock_game_generator.last_game_created

      expect(mock_game.players).to eq %i[human computer]
    end

    it 'should keep asking for an opponent until the user inputs a valid response' do
      mock_cli.fake_user_inputs = ['10', 'akj', '!', '', '2']

      tic_tac_toe.start

      expect(mock_cli.displayed_messages[2]).to eq 'Would you like to play a human or a computer?'
      expect(mock_cli.displayed_messages[3]).to eq 'Enter 1 for human, and 2 for computer:'

      # prints the same message for every invalid input (in other words, all but the last input)
      (mock_cli.fake_user_inputs.length - 1).times do |i|
        base_idx = i * 4
        expect(mock_cli.displayed_messages[base_idx + 4]).to eq 'We got an invalid input, try again!'
        expect(mock_cli.displayed_messages[base_idx + 6]).to eq 'Would you like to play a human or a computer?'
        expect(mock_cli.displayed_messages[base_idx + 7]).to eq 'Enter 1 for human, and 2 for computer:'
      end

      mock_game = mock_game_generator.last_game_created

      expect(mock_game.players).to eq %i[human computer]
    end
  end
end
