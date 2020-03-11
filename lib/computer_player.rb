class ComputerPlayer
  attr_reader :mark
  def initialize(mark:, difficulty:)
    @mark = mark
    @difficulty = difficulty
    @tried_middle = false
  end

  def make_move(board:, position:)
    board.update(@mark, position)
  end

  def get_move
    return get_easy_move if @difficulty == :easy

    get_medium_move if @difficulty == :medium
  end

  private

  def get_easy_move
    rand(1...9)
  end

  def get_medium_move
    unless @tried_middle
      @tried_middle = true
      return 5
    end

    rand(1...9)
  end
end
