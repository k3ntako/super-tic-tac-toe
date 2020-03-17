require_relative '../../lib/game_generator'

RSpec.describe GameGenerator do
  let(:game_generator) { GameGenerator.new }
  let(:ui) do
    cli = CLI.new
    UserInterface.new cli
  end

  describe 'create_a_game' do
    it 'should return a game' do
      game = game_generator.create_a_game(user_interface: ui, strategy: nil, width: 7)

      expect(game).to be_kind_of Game
    end

    it 'should return a game with two human players if strategy is not defined' do
      game = game_generator.create_a_game(user_interface: ui, strategy: nil, width: 7)
      game_state = game.instance_variable_get(:@game_state)
      players = game_state.instance_variable_get(:@players)

      expect(players[0]).to be_kind_of HumanPlayer
      expect(players[1]).to be_kind_of HumanPlayer
    end

    it 'should return a game with a human and a computer if opponent is not defined' do
      game = game_generator.create_a_game(user_interface: ui, strategy: EasyStrategy.new, width: 7)
      game_state = game.instance_variable_get(:@game_state)
      players = game_state.instance_variable_get(:@players)

      expect(players[0]).to be_kind_of HumanPlayer
      expect(players[1]).to be_kind_of ComputerPlayer
    end
  end
end
