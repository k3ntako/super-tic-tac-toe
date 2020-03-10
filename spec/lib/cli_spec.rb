require_relative '../../lib/board'
require_relative '../../lib/cli'

RSpec.describe CLI do
  let(:cli) { CLI.new }

  describe 'display_message' do
    it 'should print the string to the console given a string' do
      text = 'This should be printed to the console'
      expect { cli.display_message text }.to output(text + "\n").to_stdout
    end
  end

  describe 'get_user_input' do
    it 'should return the string passed in by the user without new line ("\n")' do
      input_text = 'input text'
      allow_any_instance_of(Kernel).to receive(:gets).and_return(input_text)

      received_input_text = cli.get_user_input
      expect(received_input_text).to eql(input_text)
    end
  end

  describe 'display_empty_line' do
    it 'should display an empty line' do
      expect { cli.display_empty_line }.to output("\n").to_stdout
    end
  end
end
