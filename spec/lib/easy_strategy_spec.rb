require_relative '../../lib/easy_strategy'

RSpec.describe EasyStrategy do
  let(:easy_strategy) { EasyStrategy.new }

  describe 'get_move' do
    it 'should return random number within the bounds of the board' do
      board = Board.new(width: 3)

      10.times { expect(easy_strategy.get_move(board: board)).to be_between(1, 9) }
    end

    it 'should return random number within the bounds of the board' do
      board = Board.new(width: 3)
      board.instance_variable_set(:@state, [
                                    ['X', 'X', 'O'],
                                    ['O', 'O', 'X'],
                                    ['X', 'O', nil]
                                  ])

      10.times { expect(easy_strategy.get_move(board: board)).to eq 9 }
    end
  end
end
