require_relative "../../lib/board"

RSpec.describe "Board" do
  context "when Board#getBoard is called" do
    it "should return an array of arrays with three nils in each" do
      boardInstance = Board.new
      board = boardInstance.getBoard

      expect(board).to eq [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil],
      ]
    end
  end
end