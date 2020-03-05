require_relative '../../lib/computer'

RSpec.describe Computer do
  let(:computer) { Computer.new(mark: 'X') }

  describe 'get_move' do
    it 'should return random number available on the board' do
      10.times { expect(computer.get_move).to be_between(1, 9) }
    end
  end
end
