class Computer
  attr_reader :mark
  def initialize(mark:)
    @mark = mark
  end

  def get_move
    rand(1...9)
  end
end
