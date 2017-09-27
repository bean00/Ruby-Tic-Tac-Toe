require 'board'
require 'player'
require 'computer_player'

describe 'get_next_move' do
  let(:b) { Board.new(3) }

  context 'when the board is already full' do
    it "returns an invalid move (0), since the computer won't make a move" do
      board = ["X", "O", "X",
               "X", "O", "O",
               "O", "X", "X"]
      b.set_board(board)
      comp = ComputerPlayer.new(2, b)

      expect(comp.get_next_move).to eq("0")
    end
  end

  xcontext 'when the computer can win now (1 move left)' do
    it 'returns the move' do
      board = ["",  "X", "O",
               "X", "O", "X",
               "X", "O", "O"]
      b.set_board(board)
      comp = ComputerPlayer.new(1, b)

      expect(comp.get_next_move).to eq("1")
    end
  end

  xcontext 'when the computer can win now (2 moves left)' do
    it 'returns the move to win' do
      board = ["O", "",  "",
               "X", "O", "X",
               "X", "O", "X"]
      b.set_board(board)
      comp = ComputerPlayer.new(2, b)

      expect(comp.get_next_move).to eq("2")
    end
  end
end


describe 'get_token' do
  let(:b) { Board.new(3) }

  context 'when the computer goes 1st' do
    it 'returns O' do
      comp = ComputerPlayer.new(1, b)

      expect(comp.get_token).to eq("O")
    end
  end

  context 'when the computer goes 2nd' do
    it 'returns O' do
      comp = ComputerPlayer.new(2, b)

      expect(comp.get_token).to eq("O")
    end
  end
end
