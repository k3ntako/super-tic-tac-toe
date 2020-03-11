require_relative '../../lib/computer_player'

RSpec.describe ComputerPlayer do
  let(:easy_computer) { ComputerPlayer.new(mark: 'X', difficulty: :easy) }

  describe 'get_move' do
    it 'should return random number available on the board on easy' do
      10.times { expect(easy_computer.get_move).to be_between(1, 9) }
    end
  end
end
