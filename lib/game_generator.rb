require_relative './game'

class GameGenerator
  def create_a_game(user_interface)
    board = Board.new
    player_one = Player.new(user_interface, 'X')
    player_two = Player.new(user_interface, 'Y')

    Game.new(user_interface, board, player_one, player_two)
  end
end
