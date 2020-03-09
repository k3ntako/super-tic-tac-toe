require_relative '../../lib/human_player'
require_relative '../../lib/game_messenger'
require_relative '../../lib/game_message_generator'

class TestUserInterface
  attr_reader :triggered_actions
  def initialize
    @triggered_actions = []
  end

  def display_message(message)
    raise ArgumentError, "Argument must be a string. Got #{message.class}" unless message.is_a? String

    @triggered_actions.push 'Displayed: ' + message

    nil
  end

  def display_board(board_state)
    board_str = board_state.flatten.map { |square| square || 'nil' }
    @triggered_actions.push board_str.join(',')

    nil
  end

  def clear_output
    @triggered_actions.push 'Cleared'
    true
  end
end

RSpec.describe GameMessenger do
  let(:board) { Board.new }
  let(:test_user_interface) { TestUserInterface.new }
  let(:game_message_generator) { GameMessageGenerator.new }
  let(:game_messenger) do
    GameMessenger.new(
      user_interface: test_user_interface,
      game_message_generator: game_message_generator
    )
  end
  let(:player) { HumanPlayer.new(user_interface, 'X') }

  describe 'display' do
    it 'should display the associated message given a symbol' do
      game_messenger.display message: :welcome
      game_messenger.display message: :not_valid_integer

      test_ui = game_messenger.instance_variable_get(:@user_interface)
      triggered_actions = test_ui.triggered_actions

      expect(triggered_actions[0]).to eq('Displayed: Welcome to a game of Tic-Tac-Toe!')
      expect(triggered_actions[1]).to eq('Displayed: Make sure it\'s an integer and try again!')
    end
  end

  describe 'display_board_with_messages' do
    let(:triggered_actions) do
      game_messenger.display_board_with_messages top_message: [:welcome], board: board, bottom_messages: [
        [:not_valid_integer],
        [:move_instruction, { current_player: 'X' }]
      ]
      test_ui = game_messenger.instance_variable_get(:@user_interface)
      test_ui.triggered_actions
    end

    it 'should clear all output' do
      expect(triggered_actions[0]).to eq('Cleared')
    end

    it 'should display top message' do
      expect(triggered_actions[1]).to eq('Displayed: Welcome to a game of Tic-Tac-Toe!')
    end

    it 'should display board' do
      expect(triggered_actions[2]).to eq('nil,nil,nil,nil,nil,nil,nil,nil,nil')
    end

    it 'should display bottom messages in order' do
      expect(triggered_actions[3]).to eq('Displayed: Make sure it\'s an integer and try again!')
      expect(triggered_actions[4]).to eq(
        'Displayed: Enter a number to make a move in the corresponding square (X\'s turn):'
      )
    end
  end
end
