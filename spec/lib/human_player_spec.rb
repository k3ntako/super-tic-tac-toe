require_relative '../../lib/human_player'
require_relative './mock_classes/board_mock'

RSpec.describe HumanPlayer do
  let(:cli) { CLI.new }
  let(:user_interface) { UserInterface.new(cli) }
  let(:mock_board) { MockBoard.new }
  let(:player) { HumanPlayer.new(user_interface, 'X') }

  describe 'get_move' do
    it 'should call get_user_input and receive the input' do
      input_text = 'input text'
      allow_any_instance_of(Kernel).to receive(:gets).and_return(input_text)

      user_move = player.get_move(board: mock_board)

      expect(user_move).to eql input_text
    end
  end

  describe 'make_move' do
    it 'should update board' do
      mark, position = player.make_move(board: mock_board, position: '1')

      expect(mark).to eq player.mark
      expect(position).to eq '1'
      expect(mock_board.triggered_actions[0]).to eq 'update'
    end
  end
end
