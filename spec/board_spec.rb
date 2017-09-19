require 'board'

describe 'move' do
  let(:b) { Board.new(3) }

  context 'when a player moves' do
    [[1, ["X", "",  "",
          "",  "",  "",
          "",  "",  ""]],
     [2, ["",  "X", "",
          "",  "",  "",
          "",  "",  ""]],
     [9, ["",  "",  "",
          "",  "",  "",
          "",  "",  "X"]]
    ].each do |move, board_after_move|
      it "sets position #{move}" do
        b.move(move, "X")

        expect(b.to_string_array).to eq(board_after_move)
      end
    end
  end

  context 'when a player moves' do
    it 'sets position 2 next' do
      board_before_move = ["X", "", "",
                           "",  "", "",
                           "",  "", ""]
      board_after_move = ["X", "O", "",
                          "",  "",  "",
                          "",  "",  ""]
      b.set_board(board_before_move)

      b.move(2, "O")

      expect(b.to_string_array).to eq(board_after_move)
    end
  end
end


describe 'to_string_array' do
  let(:b) { Board.new(3) }

  context 'with an empty board' do
    it 'returns an empty array of strings' do
      board_str = ["", "", "",
                   "", "", "",
                   "", "", ""]

      expect(b.to_string_array).to eq(board_str)
    end
  end

  context 'when 2 moves have been made' do
    it 'returns an array with 2 strings' do
      b.move(1, "X")
      b.move(6, "O")
      board_str = ["X", "", "",
                   "",  "", "O",
                   "",  "", ""]

      expect(b.to_string_array).to eq(board_str)
    end
  end

  context 'with a full board' do
    it 'returns a full array' do
      b.move(1, "X")
      b.move(2, "O")
      b.move(3, "X")
      b.move(4, "O")
      b.move(5, "X")
      b.move(6, "O")
      b.move(7, "X")
      b.move(8, "O")
      b.move(9, "X")
      board_str = ["X", "O", "X",
                   "O", "X", "O",
                   "X", "O", "X"]

      expect(b.to_string_array).to eq(board_str)
    end
  end
end


describe 'set_board' do
  context 'when passing in a board' do
    it 'sets the board' do
      b = Board.new(3)
      new_board = ["", "X", "",
                   "", "O", "",
                   "", "X", ""]

      b.set_board(new_board)

      expect(b.to_string_array).to eq(new_board)
    end
  end
end
