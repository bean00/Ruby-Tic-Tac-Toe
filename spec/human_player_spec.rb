require 'board'
require 'human_player'
require 'io_handler'

describe 'get_next_move' do
  context 'when a person moves' do
    it 'returns the move' do
      b = Board.new(3)
      h = IOHandler.new
      person = HumanPlayer.new("X", h)
      allow($stdin).to receive(:gets).and_return("4\n")

      expect(person.get_next_move(b)).to eq("4")
    end
  end
end


describe 'get_token' do
  let(:h) { IOHandler.new }

  context 'when a person goes 1st' do
    it 'returns X' do
      person = HumanPlayer.new("X", h)

      expect(person.get_token).to eq("X")
    end
  end

  context 'when a person goes 2nd' do
    it 'returns O' do
      person = HumanPlayer.new("O", h)

      expect(person.get_token).to eq("O")
    end
  end
end
