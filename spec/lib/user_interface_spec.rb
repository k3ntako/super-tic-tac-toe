require_relative '../../lib/user_interface'
require_relative '../../lib/cli'
require_relative '../../lib/board'

class TestCLI
  def display_message(text)
    "Displayed: #{text}"
  end

  def display_board(board_state)
    return nil unless board_state.is_a? Array

    board_str = board_state.flatten.map { |square| square || 'nil' }
    board_str.join(',')
  end

  def clear_output
    'Cleared!'
  end
end

RSpec.describe UserInterface do
  let(:cli) { TestCLI.new }
  let(:user_interface) { UserInterface.new(cli) }

  describe 'initialize' do
    it 'should set @platform to the CLI instance' do
      private_cli = user_interface.instance_variable_get(:@platform)
      expect(private_cli).to be_kind_of TestCLI
    end
  end

  describe 'display_message' do
    it 'should call CLI#display_message with the string argument passed in' do
      text = 'This should is a text'
      diplayed = user_interface.display_message text

      expect(diplayed).to eq "Displayed: #{text}"
    end
  end

  describe 'display_board' do
    it 'should call CLI#display_message with formatted board' do
      board = Board.new
      board_str = user_interface.display_board board.state

      expect(board_str).to eq 'nil,nil,nil,nil,nil,nil,nil,nil,nil'
    end
  end

  describe 'clear_output' do
    it 'should call CLI#display_message with formatted board' do
      expect(user_interface.clear_output).to eq 'Cleared!'
    end
  end
end
