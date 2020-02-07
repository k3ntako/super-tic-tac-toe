# frozen_string_literal: true

require_relative '../../lib/board'
require_relative '../../lib/cli'

RSpec.describe 'CLI' do
  let(:cli) { CLI.new }

  context 'when string is passed into CLI.display_message' do
    it 'should print the string to the console' do
      text = 'This should be printed to the console'
      expect { cli.display_message text }.to output(text + "\n").to_stdout
    end
  end
end
