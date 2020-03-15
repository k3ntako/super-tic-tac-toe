class HumanPlayer
  attr_reader :mark
  def initialize(user_interface, mark, input_validator)
    @user_interface = user_interface
    @input_validator = input_validator
    @mark = mark
  end

  def make_move(board:)
    position = @user_interface.get_user_input
    input_validator.move_error(board, position)
    board.update(mark, position)

    position
  end

  private

  attr_reader :input_validator
end
