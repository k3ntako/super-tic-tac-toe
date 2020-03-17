require_relative '../../lib/computer_player'

RSpec.describe ComputerPlayer do
  let(:board) { Board.new(width: 3) }
  let(:easy_strategy) { EasyStrategy.new }
  let(:computer) { ComputerPlayer.new(mark: 'O', strategy: easy_strategy) }

  describe 'make_move' do
    it 'should update board' do
      expect(easy_strategy).to receive(:get_move).and_return '2'

      position = computer.make_move(board: board)

      expect(position).to eq '2'
      expect(board.state[0][1]).to eq 'O'
    end
  end
end
