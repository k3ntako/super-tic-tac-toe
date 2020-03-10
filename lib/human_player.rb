class HumanPlayer
  attr_reader :mark
  def initialize(user_interface, mark)
    @user_interface = user_interface
    @mark = mark
  end

  def get_move
    @user_interface.get_user_input
  end
end
