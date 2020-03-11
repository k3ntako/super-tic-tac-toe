require_relative '../../lib/computer_player'
require_relative './mock_classes/board_mock'
require_relative './mock_classes/strategy_mock'

RSpec.describe ComputerPlayer do
  let(:mock_board) { MockBoard.new }
  let(:mock_strategy) { MockStrategy.new }
  let(:computer) { ComputerPlayer.new(mark: 'O', strategy: mock_strategy) }

  describe 'get_move' do
    it 'should get a move from the selected strategy' do
      computer.get_move(board: mock_board)

      expect(mock_strategy.triggered_actions[0]).to eq('get_move')
    end
  end

  describe 'make_move' do
    it 'should update board' do
      mark, position = computer.make_move(board: mock_board, position: '1')

      expect(mark).to eq computer.mark
      expect(position).to eq '1'
      expect(mock_board.triggered_actions[0]).to eq 'update'
    end
  end
end
