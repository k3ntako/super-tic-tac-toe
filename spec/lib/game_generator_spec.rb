require_relative '../../lib/game_generator'

RSpec.describe GameGenerator do
  let(:game_generator) { GameGenerator.new }
  let(:ui) do
    cli = CLI.new
    UserInterface.new cli
  end

  describe 'create_a_game' do
    it 'should return a game' do
      game = game_generator.create_a_game(ui)

      expect(game).to be_kind_of Game
    end
  end
end
