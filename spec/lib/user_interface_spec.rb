require_relative '../../lib/user_interface'
require_relative '../../lib/cli'
require_relative '../../lib/board'

# class TestCLI
#   attr_reader :diplayed_messages
#   def initialize
#     @diplayed_messages = []
#   end

#   def display_message(message)
#     @diplayed_messages.push message
#   end

#   def display_board(board_state)
#     return nil unless board_state.is_a? Array

#     board_str = board_state.flatten.map { |square| square || 'nil' }
#     @diplayed_messages.push board_str.join(',')
#   end

#   def clear_output
#     true
#   end
# end

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
    it 'should print the message' do
      message = 'This was written at PencilWorks'
      user_interface.display_message message

      test_cli = user_interface.instance_variable_get(:@platform)

      expect(test_cli.diplayed_messages.length).to eq 1
      expect(test_cli.diplayed_messages.last).to eq message
    end
  end

  describe 'display_board' do
    it 'should print the board' do
      board = Board.new
      user_interface.display_board board.state

      test_cli = user_interface.instance_variable_get(:@platform)

      expect(test_cli.diplayed_messages.length).to eq 1
      expect(test_cli.diplayed_messages.last).to eq 'nil,nil,nil,nil,nil,nil,nil,nil,nil'
    end
  end

  describe 'clear_output' do
    it 'should clear outputs' do
      expect(user_interface.clear_output).to eq true
    end
  end
end
