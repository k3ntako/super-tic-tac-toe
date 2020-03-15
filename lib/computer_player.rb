class ComputerPlayer
  attr_reader :mark
  def initialize(mark:, strategy:)
    @mark = mark
    @strategy = strategy
  end

  def make_move(board:)
    position = strategy.get_move(board: board)
    board.update(mark, position)

    position
  end

  private

  attr_reader :strategy
end
