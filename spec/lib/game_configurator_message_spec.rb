require_relative '../../lib/game_configurator_message'

RSpec.describe GameConfiguratorMessage do
  let(:game_configurator_message) { GameConfiguratorMessage.new }
  let(:ui) { UserInterface.new(TestCLI.new) }

  describe 'generate' do
    it 'should return string asking for a human or computer as an opponent' do
      output_message = game_configurator_message.generate(key: :ask_for_opponent_selection)

      expect(output_message).to eq(
        "Would you like to play a human or a computer?\nEnter 1 for human, and 2 for computer:"
      )
    end

    it 'should return string asking what difficulty they prefer' do
      output_message = game_configurator_message.generate(key: :ask_for_difficulty)

      expect(output_message).to eq(
        "Choose the computer's difficulty level.\nEnter 1 for easy, 2 for medium, and 3 for impossible:"
      )
    end
  end
end
