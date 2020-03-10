require_relative '../../lib/game_configurator_message'

RSpec.describe GameConfiguratorMessage do
  let(:game_configurator_message) { GameConfiguratorMessage.new }
  let(:ui) { UserInterface.new(TestCLI.new) }

  describe 'generate' do
    it 'should return associated static message if no param is passed in' do
      output_message = game_configurator_message.generate(key: :ask_for_opponent_selection)

      expect(output_message).to eq(
        "Would you like to play a human or a computer?\nEnter 1 for human, and 2 for computer:"
      )
    end
  end
end
