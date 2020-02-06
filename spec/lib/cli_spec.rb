# frozen_string_literal: true

require_relative '../../lib/board'
require_relative '../../lib/cli'

RSpec.describe 'CLI' do
  context 'when string is passed into CLI.put_string' do
    it 'should print the string to the console' do
      cli = CLI.new

      text = 'This should be printed to the console'
      expect { cli.put_string text }.to output(text + "\n").to_stdout
    end
  end

  context 'when CLI.put_board is called with an empty board' do
    it 'should print an empty board to the console' do
      expected_output =
        '   |   |   \n' \
        '-----------\n' \
        '   |   |   \n' \
        '-----------\n' \
        '   |   |   \n'

      cli = CLI.new

      board = Board.new
      empty_board = board.board

      board_str = cli.generate_board_str empty_board
      expect(board_str).to eq expected_output
    end
  end
end
