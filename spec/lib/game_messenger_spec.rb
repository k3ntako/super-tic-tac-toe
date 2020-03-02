require_relative '../../lib/player'
require_relative '../../lib/game_messenger'

RSpec.describe GameMessenger do
  let(:cli) { CLI.new }
  let(:user_interface) { UserInterface.new(cli) }
  let(:game_messenger) { GameMessenger.new(user_interface: user_interface) }
  let(:player) { Player.new(user_interface, 'X') }

  class TestUserInterface
    def display_message(message)
      'Displayed: ' + message
    end
  end

  describe 'display' do
    it 'should display the associated message given a symbol' do
      messages = {
        hello: 'Hello',
        bye: 'Bye'
      }
      test_user_interface = TestUserInterface.new
      game_messenger = GameMessenger.new(user_interface: test_user_interface, messages: messages)

      displayed_message = game_messenger.display message: :hello
      expect(displayed_message).to eq('Displayed: Hello')

      displayed_message = game_messenger.display message: :bye
      expect(displayed_message).to eq('Displayed: Bye')
    end
  end
end
