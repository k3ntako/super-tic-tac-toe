# frozen_string_literal: true

require_relative '../../lib/user_interface'
require_relative '../../lib/cli'
require_relative '../../lib/board'

RSpec.describe 'UserInterface' do
  let(:cli) { CLI.new }
  let(:user_interface) { UserInterface.new(cli) }

  context 'when initiated with a CLI instance' do
    it 'should set @platform to the CLI instance' do
      private_cli = user_interface.instance_variable_get(:@platform)
      expect(private_cli).to be_kind_of CLI
    end
  end

  context 'when string is passed into UserInterface#display_message' do
    it 'should call display_message with the string argument passed in' do
      text = 'This should is a text'

      expect(cli).to receive(:display_message).with(text).once

      user_interface.display_message text
    end
  end

  context 'when UserInterface.display_board' do
    it 'should call CLI#display_message with formatted board' do
      board = Board.new

      expected_output =
        "   |   |   \n" \
        "-----------\n" \
        "   |   |   \n" \
        "-----------\n" \
        "   |   |   \n"

      expect(cli).to receive(:format_board_for_display)
        .with(board.board).once
        .and_return(expected_output)

      expect(cli).to receive(:display_message).with(expected_output).once

      user_interface.display_board board.board
    end
  end
end
