require_relative '../../lib/message'

RSpec.describe Message do
  let(:message) { Message.new }
  let(:ui) { UserInterface.new(TestCLI.new) }

  describe 'generate' do
    it 'should return associated static message if no param is passed in' do
      message.instance_variable_set(
        :@static_messages,
        not_valid_integer: 'Make sure it\'s an integer and try again!'
      )

      output_message = message.generate(key: :not_valid_integer)

      expect(output_message).to eq 'Make sure it\'s an integer and try again!'
    end
  end
end
