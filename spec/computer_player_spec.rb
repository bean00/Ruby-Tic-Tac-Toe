require 'board'
require 'computer_player'
require 'score_tracker'

describe 'get_next_move' do
  context 'when the computer has taken the first position to be parsed' do
    it 'returns the move to win' do
      board = ["O", "",  "",
               "X", "O", "X",
               "X", "O", "X"]
      b = Board.create_from_string_array(board)
      s = ScoreTracker.new(b)
      comp = ComputerPlayer.new("O", "X", s)

      expect(comp.get_next_move(b)).to eq("2")
    end
  end
end


describe 'get_token' do
  let(:b) { Board.new(3) }
  let(:s) { ScoreTracker.new(b) }

  context 'when the computer goes 1st' do
    it 'returns X' do
      comp = ComputerPlayer.new("X", "O", s)

      expect(comp.get_token).to eq("X")
    end
  end

  context 'when the computer goes 2nd' do
    it 'returns O' do
      comp = ComputerPlayer.new("O", "X", s)

      expect(comp.get_token).to eq("O")
    end
  end
end
