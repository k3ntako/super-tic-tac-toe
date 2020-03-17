require_relative '../../lib/human_player'
require_relative './mock_classes/board_mock'

RSpec.describe HumanPlayer do
  let(:mock_cli) { TestCLI.new }
  let(:user_interface) { UserInterface.new(mock_cli) }
  let(:input_validator) { InputValidator.new }
  let(:board) { Board.new(width: 3) }
  let(:player) { HumanPlayer.new(user_interface, 'X', input_validator) }

  describe 'make_move' do
    it 'should update board' do
      mock_cli.fake_user_inputs = ['1']

      position = player.make_move(board: board)

      expect(position).to eq '1'
      expect(board.state[0][0]).to eq 'X'
      expect(mock_cli.triggered_actions[0]).to eq 'get_user_input'
    end
  end
end
