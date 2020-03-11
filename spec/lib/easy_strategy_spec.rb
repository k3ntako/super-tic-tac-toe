require_relative '../../lib/easy_strategy'

RSpec.describe EasyStrategy do
  let(:easy_strategy) { EasyStrategy.new }

  describe 'get_move' do
    it 'should return random number within the bounds of the board' do
      10.times { expect(easy_strategy.get_move).to be_between(1, 9) }
    end
  end
end
