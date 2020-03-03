require_relative '../../lib/player'
require_relative '../../lib/game_messenger'

class TestUserInterface
  attr_reader :triggered_actions
  def initialize
    @triggered_actions = []
  end

  def display_message(message)
    raise ArgumentError, 'Argument must be a string' unless message.is_a? String

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

GAME_MESSENGER_MESSAGES = {
  hello: 'Hello',
  instruction: 'Make your move',
  bye: 'Bye'
}.freeze

RSpec.describe GameMessenger do
  let(:board) { Board.new }
  let(:test_user_interface) { TestUserInterface.new }
  let(:game_messenger) { GameMessenger.new(user_interface: test_user_interface, messages: GAME_MESSENGER_MESSAGES) }
  let(:player) { Player.new(user_interface, 'X') }

  describe 'display' do
    it 'should display the associated message given a symbol' do
      game_messenger.display message: :hello
      game_messenger.display message: :bye

      test_ui = game_messenger.instance_variable_get(:@user_interface)
      triggered_actions = test_ui.triggered_actions

      expect(triggered_actions[0]).to eq('Displayed: Hello')
      expect(triggered_actions[1]).to eq('Displayed: Bye')
    end
  end

  describe 'display_board_with_messages' do
    let(:triggered_actions) do
      game_messenger.display_board_with_messages top_message: :hello, board: board, bottom_messages: %i[instruction bye]
      test_ui = game_messenger.instance_variable_get(:@user_interface)
      test_ui.triggered_actions
    end

    it 'should clear all output' do
      expect(triggered_actions[0]).to eq('Cleared')
    end

    it 'should display top message' do
      expect(triggered_actions[1]).to eq('Displayed: Hello')
    end

    it 'should display board' do
      expect(triggered_actions[2]).to eq('nil,nil,nil,nil,nil,nil,nil,nil,nil')
    end

    it 'should display bottom messages in order' do
      expect(triggered_actions[3]).to eq('Displayed: Make your move')
      expect(triggered_actions[4]).to eq('Displayed: Bye')
    end
  end
end
