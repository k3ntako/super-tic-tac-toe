require_relative '../../lib/player'
require_relative '../../lib/game_messenger'

class TestUserInterface
  def display_message(message)
    'Displayed: ' + message
  end

  def display_board(board_state)
    board_str = board_state.flatten.map { |square| square || 'nil' }
    'Displayed: ' + board_str.join(',')
  end
end

GAME_MESSENGER_MESSAGES = {
  hello: 'Hello',
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
end
