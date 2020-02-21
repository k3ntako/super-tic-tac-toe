require_relative './game'

class GameGenerator
  def create_a_game(user_interface)
    board = Board.new
    player = Player.new(user_interface, 'X')

    Game.new(user_interface, board, player)
  end
end
