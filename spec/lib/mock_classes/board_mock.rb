class MockBoard
  attr_reader :triggered_actions
  def initialize
    @triggered_actions = []
  end

  def update(mark, position)
    @triggered_actions.push('update')
    [mark, position]
  end
end
