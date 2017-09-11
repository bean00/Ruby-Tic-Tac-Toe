require 'board'

describe 'move' do
  [[1, ["x", "",  "",
        "",  "",  "",
        "",  "",  ""]],
   [2, ["",  "x", "",
        "",  "",  "",
        "",  "",  ""]],
   [9, ["",  "",  "",
        "",  "",  "",
        "",  "",  "x"]]
  ].each do |move, board_after_move|
    it "moves to the position #{move}" do
      board = Board.new

      board.move(move, "x")

      expect(board.board).to eq(board_after_move)
    end
  end

  it 'moves to 2 next' do
    board_before_move = ["x", "", "",
                         "",  "", "",
                         "",  "", ""]
    board_after_move = ["x", "o", "",
                        "",  "",  "",
                        "",  "",  ""]
    board = Board.new(board_before_move)

    board.move(2, "o")

    expect(board.board).to eq(board_after_move)
  end
end


describe 'get_available_moves' do
  it 'returns [2] when there is 1 more move left' do
    board = Board.new
    board.move(1, "x")
    board.move(3, "o")
    board.move(4, "x")
    board.move(6, "o")
    board.move(5, "x")
    board.move(7, "o")
    board.move(8, "x")
    board.move(9, "o")
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
    board.move(2, "x")
    board.move(3, "o")
    board.move(4, "x")
    board.move(5, "o")
    board.move(7, "x")
    array_with_moves = [1, 6, 8, 9]

    actual_array = board.get_available_moves

    expect(actual_array).to eq(array_with_moves)
  end
end


describe 'to_string' do
  it 'returns a formatted board if all positions are "x"s' do
    board = Board.new
    board.move(1, "x")
    board.move(2, "x")
    board.move(3, "x")
    board.move(4, "x")
    board.move(5, "x")
    board.move(6, "x")
    board.move(7, "x")
    board.move(8, "x")
    board.move(9, "x")
    formatted_board = " x | x | x \n" +
                      "---+---+---\n" +
                      " x | x | x \n" + 
                      "---+---+---\n" +
                      " x | x | x "

    expect(board.to_string).to eq(formatted_board)
  end

  it 'returns a formatted board if all positions are empty' do
    board = Board.new
    formatted_board = "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   "

    expect(board.to_string).to eq(formatted_board)
  end

  it 'returns a formatted board if positions are mixed' do
    board = Board.new
    board.move(5, "x")
    board.move(1, "o")
    board.move(9, "x")
    board.move(6, "o")
    formatted_board = " o |   |   \n" +
                      "---+---+---\n" +
                      "   | x | o \n" +
                      "---+---+---\n" +
                      "   |   | x "

    expect(board.to_string).to eq(formatted_board)
  end
end


describe 'position_is_empty?' do
  it 'returns true for an empty position' do
    board = Board.new
    board.move(4, "x")
    board.move(5, "o")

    position_is_empty = board.position_is_empty?(2)

    expect(position_is_empty).to be true
  end

  it 'returns false for a position that was taken' do
    board = Board.new
    board.move(6, "x")

    position_is_empty = board.position_is_empty?(6)

    expect(position_is_empty).to be false
  end
end
