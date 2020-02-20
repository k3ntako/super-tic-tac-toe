# frozen_string_literal: true

require_relative '../../lib/board'
require_relative '../../lib/game_end_evaluator'

RSpec.describe GameEndEvaluator do
  let(:game_end_evaluator) { GameEndEvaluator.new }
  let(:board) { Board.new }

  context 'when find_winner is called with board' do
    it 'should return nil if there is no winner' do
      winner = game_end_evaluator.find_winner board

      expect(winner).to be nil
    end

    it 'should return horizontal winner' do
      board.instance_variable_set(
        :@board,
        [
          [nil, 'O', 'O'],
          ['X', 'X', 'X'],
          ['O', 'X', nil]
        ]
      )
      winner = game_end_evaluator.find_winner board

      expect(winner).to be 'X'
    end

    it 'should return vertical winner' do
      board.instance_variable_set(
        :@board,
        [
          ['O', 'X', 'O'],
          ['O', nil, 'X'],
          ['O', 'X', 'X']
        ]
      )
      winner = game_end_evaluator.find_winner board

      expect(winner).to be 'O'
    end

    it 'should return diagonal winner from left to right' do
      board.instance_variable_set(
        :@board,
        [
          ['X', 'X', 'O'],
          ['O', 'X', 'X'],
          ['O', 'O', 'X']
        ]
      )
      winner = game_end_evaluator.find_winner board

      expect(winner).to be 'X'
    end

    it 'should return diagonal winner from right to left' do
      board.instance_variable_set(
        :@board,
        [
          [nil, 'X', 'O'],
          ['X', 'O', 'X'],
          ['O', 'O', 'X']
        ]
      )
      winner = game_end_evaluator.find_winner board

      expect(winner).to be 'O'
    end
  end

  context 'when any_remaining_moves? is called' do
    it 'should return true if there are moves left' do
      allow(board).to receive(:find_available_positions).and_return([1, 2, 3])
      available_moves_exist = game_end_evaluator.any_remaining_moves? board
      expect(available_moves_exist).to be true
    end

    it 'should return false if there are no moves left' do
      allow(board).to receive(:find_available_positions).and_return([])
      available_moves_exist = game_end_evaluator.any_remaining_moves? board
      expect(available_moves_exist).to be false
    end
  end
end
