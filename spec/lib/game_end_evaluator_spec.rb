require_relative '../../lib/board'
require_relative '../../lib/game_end_evaluator'

RSpec.describe GameEndEvaluator do
  let(:game_end_evaluator) { GameEndEvaluator.new }
  let(:board) { Board.new }

  describe 'player_won?' do
    context 'when there is no winner' do
      it 'should return false' do
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to be false
      end
    end

    context 'when there is a winner' do
      it 'should return true for the horizontal winner' do
        board.instance_variable_set(
          :@board,
          [
            [nil, 'O', 'O'],
            ['X', 'X', 'X'],
            ['O', 'X', nil]
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq true
      end

      it 'should return true for the vertical winner' do
        board.instance_variable_set(
          :@board,
          [
            ['O', 'X', 'O'],
            ['O', nil, 'X'],
            ['O', 'X', 'X']
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq true
      end

      it 'should return true for the diagonal winner from left to right' do
        board.instance_variable_set(
          :@board,
          [
            ['X', 'X', 'O'],
            ['O', 'X', 'X'],
            ['O', 'O', 'X']
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq true
      end

      it 'should return true for the diagonal winner from right to left' do
        board.instance_variable_set(
          :@board,
          [
            [nil, 'X', 'O'],
            ['X', 'O', 'X'],
            ['O', 'O', 'X']
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq true
      end
    end
  end

  describe 'any_remaining_moves?' do
    context 'when there are moves left' do
      it 'should return true' do
        allow(board).to receive(:find_available_positions).and_return([1, 2, 3])
        available_moves_exist = game_end_evaluator.any_remaining_moves? board
        expect(available_moves_exist).to be true
      end
    end

    context 'when there are no moves left' do
      it 'should return false' do
        allow(board).to receive(:find_available_positions).and_return([])
        available_moves_exist = game_end_evaluator.any_remaining_moves? board
        expect(available_moves_exist).to be false
      end
    end
  end
end
