require_relative '../../lib/player'
require_relative '../../lib/game_messenger'

class TestUserInterface
  attr_reader :displayed_messages
  def initialize
    @displayed_messages = []
  end

  def display_message(message)
    raise ArgumentError, 'Argument must be a string' unless message.is_a? String

    @displayed_messages.push message
    'Displayed: ' + message
  end

  def display_board(board_state)
    board_str = board_state.flatten.map { |square| square || 'nil' }
    @displayed_messages.push board_str.join(',')
  end

  def clear_output
    @displayed_messages.push 'Cleared'
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
      displayed_message = game_messenger.display message: :hello
      expect(displayed_message).to eq('Displayed: Hello')

      displayed_message = game_messenger.display message: :bye
      expect(displayed_message).to eq('Displayed: Bye')
    end
  end

  describe 'display' do
    let(:displayed_messages) do
      game_messenger.display_messages top_message: :hello, board: board, bottom_messages: %i[instruction bye]
      test_ui = game_messenger.instance_variable_get(:@user_interface)
      test_ui.displayed_messages
    end

    it 'should clear all output' do
      expect(displayed_messages[0]).to eq('Cleared')
    end

    it 'should display top message' do
      expect(displayed_messages[1]).to eq('Hello')
    end

    it 'should display board' do
      expect(displayed_messages[2]).to eq('nil,nil,nil,nil,nil,nil,nil,nil,nil')
    end

    it 'should display bottom messages in order' do
      expect(displayed_messages[3]).to eq('Make your move')
      expect(displayed_messages[4]).to eq('Bye')
    end
  end
end
