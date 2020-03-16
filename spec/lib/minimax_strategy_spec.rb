require_relative '../../lib/minimax_strategy'

RSpec.describe MinimaxStrategy do
  let(:game_end_evaluator) { GameEndEvaluator.new }
  let(:minimax_strategy) do
    MinimaxStrategy.new(game_end_evaluator: game_end_evaluator)
  end

  describe 'get_move' do
    it 'should choosing winning move' do
      board = Board.new(width: 3)
      board.instance_variable_set(
        :@board,
        [
          ['O', 'O', nil],
          ['X', nil, 'X'],
          ['X', nil, nil]
        ]
      )

      best_move = minimax_strategy.get_move(board: board)
      expect(best_move).to eq 3
    end

    it 'should choosing winning move over blocking' do
      board = Board.new(width: 3)
      board.instance_variable_set(
        :@board,
        [
          ['X', 'X', nil],
          ['O', 'O', nil],
          ['X', nil, nil]
        ]
      )

      best_move = minimax_strategy.get_move(board: board)
      expect(best_move).to eq 6
    end

    it 'should block given no winning moves' do
      board = Board.new(width: 3)
      board.instance_variable_set(
        :@board,
        [
          ['X', 'X', nil],
          ['O', nil, nil],
          ['X', nil, 'O']
        ]
      )

      best_move = minimax_strategy.get_move(board: board)
      expect(best_move).to eq 3
    end

    it 'should block given no winning moves' do
      board = Board.new(width: 3)
      board.instance_variable_set(
        :@board,
        [
          ['O', nil, 'X'],
          [nil, 'X', nil],
          [nil, nil, nil]
        ]
      )

      best_move = minimax_strategy.get_move(board: board)
      expect(best_move).to eq 7
    end
  end
end
