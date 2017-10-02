require 'board'
require 'player'
require 'human_player'

describe 'get_next_move' do
  context 'when a person moves' do
    it 'returns the move' do
      b = Board.new(3)
      person = HumanPlayer.new(1, false)
      allow($stdin).to receive(:gets).and_return("4\n")

      expect(person.get_next_move(b)).to eq("4")
    end
  end
end


describe 'get_token' do
  context 'when a person goes 1st against another person' do
    it 'returns X' do
      person = HumanPlayer.new(1, false)

      expect(person.get_token).to eq("X")
    end
  end

  context 'when a person goes 2nd against another person' do
    it 'returns O' do
      person = HumanPlayer.new(2, false)

      expect(person.get_token).to eq("O")
    end
  end

  context 'when a person goes 1st against a computer' do
    it 'returns X' do
      person = HumanPlayer.new(1, true)

      expect(person.get_token).to eq("X")
    end
  end

  context 'when a person goes 2nd against a computer' do
    it 'returns O' do
      person = HumanPlayer.new(2, true)

      expect(person.get_token).to eq("X")
    end
  end
end
