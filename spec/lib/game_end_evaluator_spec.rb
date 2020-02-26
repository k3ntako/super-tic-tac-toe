require_relative '../../lib/board'
require_relative '../../lib/game_end_evaluator'

RSpec.describe GameEndEvaluator do
  let(:game_end_evaluator) { GameEndEvaluator.new }
  let(:board) { Board.new }

  describe 'player_won?' do
    context 'when there is no winner' do
      it 'should return false for an empty board' do
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to be false
      end

      it 'should return false for an empty board without a winner' do
        board.instance_variable_set(
          :@board,
          [
            [nil, 'O', 'X'],
            ['X', 'X', 'O'],
            ['O', 'X', nil]
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq false
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

  describe 'game_over?' do
    context 'when there are moves left and there is no winner' do
      it 'should return false' do
        board.instance_variable_set(
          :@board,
          [
            [nil, 'X', 'O'],
            ['O', 'X', 'X'],
            ['X', 'O', nil]
          ]
        )
        is_game_over = game_end_evaluator.game_over? board

        expect(is_game_over).to eq false
      end
    end

    context 'when there are moves left but there is a winner' do
      it 'should return true' do
        board.instance_variable_set(
          :@board,
          [
            [nil, 'X', 'O'],
            ['O', 'X', 'X'],
            ['O', 'X', nil]
          ]
        )
        is_game_over = game_end_evaluator.game_over? board

        expect(is_game_over).to eq true
      end
    end

    context 'when there are no moves left' do
      it 'should return true' do
        board.instance_variable_set(
          :@board,
          [
            ['X', 'X', 'O'],
            ['O', 'X', 'X'],
            ['O', 'O', 'X']
          ]
        )
        is_game_over = game_end_evaluator.game_over? board

        expect(is_game_over).to eq true
      end
    end
  end
end
