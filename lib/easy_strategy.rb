class EasyStrategy
  def get_move(board:)
    board.find_available_positions.sample
  end
end
