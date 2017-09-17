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
      b = Board.new(3)

      b.move(move, "X")

      expect(b.to_string_array).to eq(board_after_move)
    end
  end

  it 'moves to 2 next' do
    board_before_move = ["X", "", "",
                         "",  "", "",
                         "",  "", ""]

    board_after_move = ["X", "O", "",
                        "",  "",  "",
                        "",  "",  ""]
    b = Board.new(3)
    b.set_board(board_before_move)

    b.move(2, "O")

    expect(b.to_string_array).to eq(board_after_move)
  end
end


describe 'get_available_moves' do
  it 'returns [2] when there is 1 more move left' do
    b = Board.new(3)
    b.move(1, "X")
    b.move(3, "O")
    b.move(4, "X")
    b.move(6, "O")
    b.move(5, "X")
    b.move(7, "O")
    b.move(8, "X")
    b.move(9, "O")
    expected_array = [2]

    actual_array = b.get_available_moves

    expect(actual_array).to eq(expected_array)
  end

  it 'returns all moves when no move has been made yet' do
    b = Board.new(3)
    array_with_all_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    actual_array = b.get_available_moves

    expect(actual_array).to eq(array_with_all_moves)
  end

  it 'returns [1, 6, 8, 9] when the other 5 moves have been made' do
    b = Board.new(3)
    b.move(2, "X")
    b.move(3, "O")
    b.move(4, "X")
    b.move(5, "O")
    b.move(7, "X")
    array_with_moves = [1, 6, 8, 9]

    actual_array = b.get_available_moves

    expect(actual_array).to eq(array_with_moves)
  end
end


describe 'position_is_empty?' do
  it 'returns true for an empty position' do
    b = Board.new(3)
    b.move(4, "X")
    b.move(5, "O")

    position_is_empty = b.position_is_empty?(2)

    expect(position_is_empty).to be true
  end

  it 'returns false for a position that was taken' do
    b = Board.new(3)
    b.move(6, "X")

    position_is_empty = b.position_is_empty?(6)

    expect(position_is_empty).to be false
  end
end


describe 'to_string_array' do
  it 'returns an empty array of strings for an empty board' do
    b = Board.new(3)
    board_str = ["", "", "",
                 "", "", "",
                 "", "", ""]

    expect(b.to_string_array).to eq(board_str)
  end

  it 'returns an array with 2 strings after 2 moves were made' do
    b = Board.new(3)
    b.move(1, "X")
    b.move(6, "O")
    board_str = ["X", "", "",
                 "",  "", "O",
                 "",  "", ""]

    expect(b.to_string_array).to eq(board_str)
  end

  it 'returns a full array for a full board' do
    b = Board.new(3)
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


describe 'set_board' do
  it 'sets the board' do
    b = Board.new(3)
    new_board = ["", "X", "",
                 "", "O", "",
                 "", "X", ""]

    b.set_board(new_board)

    expect(b.to_string_array).to eq(new_board)
  end
end
