class ComputerPlayer
  attr_reader :mark
  def initialize(mark:, strategy:)
    @mark = mark
    @strategy = strategy
  end

  def make_move(board:, position:)
    board.update(mark, position)
  end

  def get_move(board:)
    strategy.get_move(board: board)
  end

  private

  attr_reader :strategy
end
