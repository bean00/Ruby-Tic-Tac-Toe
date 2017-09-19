require 'board'
require 'player'
require 'computer_player'

describe 'get_next_move' do
  let(:b) { Board.new(3) }

  context 'when the computer has 1 move left' do
    it 'returns the move' do
      new_state = ["",  "X", "O",
                   "X", "O", "X",
                   "X", "O", "O"]
      b.set_board(new_state)
      comp = ComputerPlayer.new(1, b.to_string_array)

      expect(comp.get_next_move).to eq("1")
    end
  end

  context 'when the computer has 2 moves left' do
    it 'returns the move it chooses' do
      new_state = ["O", "",  "",
                   "X", "O", "X",
                   "X", "O", "X"]
      b.set_board(new_state)
      comp = ComputerPlayer.new(2, b.to_string_array)

      expect(comp.get_next_move).to eq("2")
    end
  end
end


describe 'get_token' do
  let(:b) { Board.new(3) }

  context 'when the computer goes 1st' do
    it 'returns O' do
      comp = ComputerPlayer.new(1, b.to_string_array)

      expect(comp.get_token).to eq("O")
    end
  end

  context 'when the computer goes 2nd' do
    it 'returns O' do
      comp = ComputerPlayer.new(2, b.to_string_array)

      expect(comp.get_token).to eq("O")
    end
  end
end
