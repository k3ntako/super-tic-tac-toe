require_relative '../../lib/board'
require_relative '../../lib/game_end_evaluator'

RSpec.describe GameEndEvaluator do
  let(:game_end_evaluator) { GameEndEvaluator.new }

  describe 'player_won?' do
    context 'when there is no winner' do
      it 'should return false for an empty board' do
        board = Board.new(width: 3)
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to be false
      end

      it 'should return false for a board without a winner' do
        board = Board.new(width: 3)
        board.instance_variable_set(
          :@state,
          [
            [nil, 'O', 'X'],
            ['X', 'X', 'O'],
            ['O', 'X', nil]
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq false
      end

      it 'should return false for a larger board without a winner' do
        board = Board.new(width: 5)
        board.instance_variable_set(
          :@state,
          [
            [nil, 'O', 'X', 'X', nil],
            ['X', 'X', 'O', nil, nil],
            ['O', 'X', 'O', 'O', 'O'],
            ['O', 'X', nil, nil, nil],
            ['O', 'X', nil, nil, nil]
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq false
      end
    end

    context 'when there is a winner' do
      it 'should return true for the horizontal winner' do
        board = Board.new(width: 3)
        board.instance_variable_set(
          :@state,
          [
            [nil, 'O', 'O'],
            ['X', 'X', 'X'],
            ['O', 'X', nil]
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq true
      end

      it 'should return true for the horizontal winner - larger board' do
        board = Board.new(width: 6)
        board.instance_variable_set(
          :@state,
          [
            [nil, 'O', 'O', nil, nil, nil],
            ['X', 'X', 'X', nil, nil, nil],
            ['O', 'X', 'X', 'X', 'X', nil],
            ['O', 'X', 'X', nil, nil, nil],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'X', 'X', nil, nil, nil]

          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq true
      end

      it 'should return true for the vertical winner' do
        board = Board.new(width: 3)
        board.instance_variable_set(
          :@state,
          [
            ['O', 'X', 'O'],
            ['O', nil, 'X'],
            ['O', 'X', 'X']
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq true
      end

      it 'should return true for the vertical winner - larger board' do
        board = Board.new(width: 4)
        board.instance_variable_set(
          :@state,
          [
            ['O', 'X', 'X', nil],
            [nil, 'O', 'X', nil],
            ['O', nil, 'X', nil],
            ['O', nil, 'X', nil]
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq true
      end

      it 'should return true for the diagonal winner from left to right' do
        board = Board.new(width: 3)
        board.instance_variable_set(
          :@state,
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
        board = Board.new(width: 3)
        board.instance_variable_set(
          :@state,
          [
            [nil, 'X', 'O'],
            ['X', 'O', 'X'],
            ['O', 'O', 'X']
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq true
      end

      it 'should return true for the diagonal winner - larger board' do
        board = Board.new(width: 5)
        board.instance_variable_set(
          :@state,
          [
            ['O', 'X', 'O', nil, nil],
            ['X', 'O', 'X', nil, nil],
            ['X', nil, 'O', nil, nil],
            ['X', nil, 'X', 'O', nil],
            ['X', 'O', 'X', nil, 'O']
          ]
        )
        did_player_win = game_end_evaluator.player_won? board

        expect(did_player_win).to eq true
      end
    end
  end

  describe 'game_over?' do
    it 'should return false if there are moves left and there is no winner' do
      board = Board.new(width: 3)
      board.instance_variable_set(
        :@state,
        [
          [nil, 'X', 'O'],
          ['O', 'X', 'X'],
          ['X', 'O', nil]
        ]
      )
      is_game_over = game_end_evaluator.game_over? board

      expect(is_game_over).to eq false
    end

    it 'should return true if there are moves left but there is a winner' do
      board = Board.new(width: 3)
      board.instance_variable_set(
        :@state,
        [
          [nil, 'X', 'O'],
          ['O', 'X', 'X'],
          ['O', 'X', nil]
        ]
      )
      is_game_over = game_end_evaluator.game_over? board

      expect(is_game_over).to eq true
    end

    it 'should return true when there are no moves left' do
      board = Board.new(width: 3)
      board.instance_variable_set(
        :@state,
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

  describe 'find_winner' do
    it 'should return horizontal winner' do
      board = Board.new(width: 3)
      board.instance_variable_set(
        :@state,
        [
          ['X', 'X', 'X'],
          ['O', 'O', 'X'],
          ['O', 'X', 'O']
        ]
      )

      winner = game_end_evaluator.find_winner(board: board)
      expect(winner).to eq 'X'
    end

    it 'should return vertical winner' do
      board = Board.new(width: 5)
      board.instance_variable_set(
        :@state,
        [
          ['X', 'X', 'O', nil, nil],
          ['O', 'X', 'O', 'X', 'X'],
          ['X', 'X', 'O', 'X', 'X'],
          ['O', 'O', 'O', nil, nil],
          ['O', 'O', 'O', nil, nil]
        ]
      )

      winner = game_end_evaluator.find_winner(board: board)
      expect(winner).to eq 'O'
    end

    it 'should return horizontal winner' do
      board = Board.new(width: 6)
      board.instance_variable_set(
        :@state,
        [
          ['O', 'O', nil, nil, nil, nil],
          ['O', 'O', 'X', nil, nil, nil],
          ['X', 'X', 'O', 'X', 'X', nil],
          ['X', 'X', nil, 'O', nil, nil],
          ['X', 'X', 'O', 'X', 'O', nil],
          ['X', 'O', 'O', nil, nil, 'O']
        ]
      )

      winner = game_end_evaluator.find_winner(board: board)
      expect(winner).to eq 'O'
    end
  end
end
