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

  context 'when prompt_user_input is called' do
    it 'should return string passed in without new line ("\n")' do
      input_text = 'input text'
      allow_any_instance_of(Kernel).to receive(:gets).and_return(input_text)

      received_input_text = cli.prompt_user_input
      expect(received_input_text).to eql(input_text)
    end
  end

  context 'when display_board is called with an empty board' do
    it 'should print an empty board to the console' do
      expected_output =
        " 1 | 2 | 3 \n" \
        "-----------\n" \
        " 4 | 5 | 6 \n" \
        "-----------\n" \
        " 7 | 8 | 9 \n"

      board = Board.new

      expect(cli).to receive(:display_message).with(expected_output)

      cli.display_board board.board
    end
  end
end
