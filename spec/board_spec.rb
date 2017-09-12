require 'board'

describe 'move' do
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
    it "moves to position #{move}" do
      board = Board.new

      board.move(move, "X")

      expect(board.to_string).to eq(board_after_move)
    end
  end

  it 'moves to 2 next' do
    board_before_move = ["X", "", "",
                         "",  "", "",
                         "",  "", ""]

    board_after_move = ["X", "O", "",
                        "",  "",  "",
                        "",  "",  ""]
    board = Board.new(board_before_move)

    board.move(2, "O")

    expect(board.to_string).to eq(board_after_move)
  end
end


describe 'get_available_moves' do
  it 'returns [2] when there is 1 more move left' do
    board = Board.new
    board.move(1, "X")
    board.move(3, "O")
    board.move(4, "X")
    board.move(6, "O")
    board.move(5, "X")
    board.move(7, "O")
    board.move(8, "X")
    board.move(9, "O")
    expected_array = [2]

    actual_array = board.get_available_moves

    expect(actual_array).to eq(expected_array)
  end

  it 'returns all moves when no move has been made yet' do
    board = Board.new
    array_with_all_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    actual_array = board.get_available_moves

    expect(actual_array).to eq(array_with_all_moves)
  end

  it 'returns [1, 6, 8, 9] when the other 5 moves have been made' do
    board = Board.new
    board.move(2, "X")
    board.move(3, "O")
    board.move(4, "X")
    board.move(5, "O")
    board.move(7, "X")
    array_with_moves = [1, 6, 8, 9]

    actual_array = board.get_available_moves

    expect(actual_array).to eq(array_with_moves)
  end
end


describe 'position_is_empty?' do
  it 'returns true for an empty position' do
    board = Board.new
    board.move(4, "X")
    board.move(5, "O")

    position_is_empty = board.position_is_empty?(2)

    expect(position_is_empty).to be true
  end

  it 'returns false for a position that was taken' do
    board = Board.new
    board.move(6, "X")

    position_is_empty = board.position_is_empty?(6)

    expect(position_is_empty).to be false
  end
end


describe 'to_string' do
  it 'returns an empty array of strings for an empty board' do
    board = Board.new
    board_str = ["", "", "",
                 "", "", "",
                 "", "", ""]

    expect(board.to_string).to eq(board_str)
  end

  it 'returns an array with 2 strings after 2 moves were made' do
    board = Board.new
    board.move(1, "x")
    board.move(6, "o")
    board_str = ["x", "", "",
                 "",  "", "o",
                 "",  "", ""]

    expect(board.to_string).to eq(board_str)
  end

  it 'returns a full array for a full board' do
    board = Board.new
    board.move(1, "x")
    board.move(2, "o")
    board.move(3, "x")
    board.move(4, "o")
    board.move(5, "x")
    board.move(6, "o")
    board.move(7, "x")
    board.move(8, "o")
    board.move(9, "x")
    board_str = ["x", "o", "x",
                 "o", "x", "o",
                 "x", "o", "x"]

    expect(board.to_string).to eq(board_str)
  end
end
