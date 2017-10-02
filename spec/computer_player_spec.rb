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
      comp = ComputerPlayer.new(2, b.get_side_length)

      expect(comp.get_next_move(b)).to eq("0")
    end
  end

  context 'when the computer can win now (1 move left)' do
    it 'returns the move to win' do
      board = ["",  "X", "O",
               "X", "O", "X",
               "X", "O", "O"]
      b.set_board(board)
      comp = ComputerPlayer.new(1, b.get_side_length)

      expect(comp.get_next_move(b)).to eq("1")
    end
  end

  context 'when the computer can win now (2 moves left)' do
    it 'returns the move to win' do
      board = ["O", "",  "",
               "X", "O", "X",
               "X", "O", "X"]
      b.set_board(board)
      comp = ComputerPlayer.new(2, b.get_side_length)

      expect(comp.get_next_move(b)).to eq("2")
    end
  end
  
  context 'when the computer can win now (3 moves left)' do
    it 'returns the move to win' do
      board = ["",  "",  "X",
               "X", "O", "",
               "O", "O", "X"]
      b.set_board(board)
      comp = ComputerPlayer.new(1, b.get_side_length)

      expect(comp.get_next_move(b)).to eq("2")
    end
  end

  context "when the computer can't win (2 moves left)" do
    it 'returns the move to force a draw' do
      board = ["X", "O", "",
               "O", "O", "X",
               "X", "X", ""]
      b.set_board(board)
      comp = ComputerPlayer.new(2, b.get_side_length)

      expect(comp.get_next_move(b)).to eq("9")
    end
  end

  context "when the computer determines that it can't win" do
    it 'returns the move to eventually draw' do
      board = ["X", "",  "",
               "",  "O", "",
               "X", "",  ""]
      b.set_board(board)
      comp = ComputerPlayer.new(2, b.get_side_length)

      expect(comp.get_next_move(b)).to eq("4")
    end
  end

  context "when the computer determines that it can win" do
    it 'returns the move to eventually win' do
      board = ["", "",  "O",
               "", "",  "X",
               "", "X", "O"]
      b.set_board(board)
      comp = ComputerPlayer.new(1, b.get_side_length)

      expect(comp.get_next_move(b)).to eq("1")
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
