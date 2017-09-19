require 'board'
require 'board_tracker'

describe 'get_available_moves' do
  let(:b) { Board.new(3) }

  context 'when there is 1 move left' do
    it 'returns that move' do
      b.move(1, "X")
      b.move(3, "O")
      b.move(4, "X")
      b.move(6, "O")
      b.move(5, "X")
      b.move(7, "O")
      b.move(8, "X")
      b.move(9, "O")
      bt = BoardTracker.new(b.to_string_array)
      expected_array = [2]

      expect(bt.get_available_moves).to eq(expected_array)
    end
  end

  context 'when no move has been made yet' do
    it 'returns all moves' do
      bt = BoardTracker.new(b.to_string_array)
      array_with_all_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]

      expect(bt.get_available_moves).to eq(array_with_all_moves)
    end
  end

  context 'when 5 moves have been made' do
    it 'returns the other 4 moves' do
      b.move(2, "X")
      b.move(3, "O")
      b.move(4, "X")
      b.move(5, "O")
      b.move(7, "X")
      bt = BoardTracker.new(b.to_string_array)
      array_with_moves = [1, 6, 8, 9]

      expect(bt.get_available_moves).to eq(array_with_moves)
    end
  end
end


describe 'set_board_array' do
  context 'when the board changes' do
    it 'sets the state correctly' do
      b = Board.new(3)
      bt = BoardTracker.new(b.to_string_array)
      b.move(2, "X")
      new_board_array = ["", "X", "",
                         "", "",  "",
                         "", "",  ""]
      
      expect(bt.set_board_array(b.to_string_array)).to eq(new_board_array)
    end
  end
end
