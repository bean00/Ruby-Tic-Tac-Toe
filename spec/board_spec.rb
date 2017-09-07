require 'board'

describe 'move' do
  [["top left", :tl, ["x", "",  "",
                      "",  "",  "",
                      "",  "",  ""]],
   ["top", :t, ["",  "x", "",
                "",  "",  "",
                "",  "",  ""]],
   ["bottom right", :br, ["",  "",  "",
                          "",  "",  "",
                          "",  "",  "x"]]
  ].each do |position, short_position, board_after_move|
    it "moves to the #{position} position" do
      board = Board.new

      board.move(short_position, "x")

      expect(board.board).to eq(board_after_move)
    end
  end

  it 'moves to the top next' do
    board_before_move = ["x", "", "",
                         "",  "", "",
                         "",  "", ""]
    board_after_move = ["x", "o", "",
                        "",  "",  "",
                        "",  "",  ""]
    board = Board.new(board_before_move)

    board.move(:t, "o")

    expect(board.board).to eq(board_after_move)
  end
end


describe 'get_available_moves' do
  it 'returns [t] when there is 1 more move left' do
    board = Board.new
    board.move(:tl, "x")
    board.move(:tr, "o")
    board.move(:l, "x")
    board.move(:r, "o")
    board.move(:c, "x")
    board.move(:bl, "o")
    board.move(:b, "x")
    board.move(:br, "o")
    array_with_t = [:t]

    actual_array = board.get_available_moves

    expect(array_with_t).to eq(actual_array)
  end

  it 'returns all moves when no move has been made yet' do
    board = Board.new
    array_with_all_moves = [:tl, :t, :tr, :l, :c, :r, :bl, :b, :br]

    actual_array = board.get_available_moves

    expect(array_with_all_moves).to eq(actual_array)
  end

  it 'returns [tl, r, b, br] when the other 5 moves have been made' do
    board = Board.new
    board.move(:t, "x")
    board.move(:tr, "o")
    board.move(:l, "x")
    board.move(:c, "o")
    board.move(:bl, "x")
    array_with_moves = [:tl, :r, :b, :br]

    actual_array = board.get_available_moves

    expect(array_with_moves).to eq(actual_array)
  end
end


describe 'to_string' do
  it 'returns a formatted board if all positions are "x"s' do
    board = Board.new
    board.move(:tl, "x")
    board.move(:t, "x")
    board.move(:tr, "x")
    board.move(:l, "x")
    board.move(:c, "x")
    board.move(:r, "x")
    board.move(:bl, "x")
    board.move(:b, "x")
    board.move(:br, "x")
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
    board.move(:c, "x")
    board.move(:tl, "o")
    board.move(:br, "x")
    board.move(:r, "o")
    formatted_board = " o |   |   \n" +
                      "---+---+---\n" +
                      "   | x | o \n" +
                      "---+---+---\n" +
                      "   |   | x "

    expect(board.to_string).to eq(formatted_board)
  end
end


describe 'is_valid?' do
  it 'returns true for a valid move' do
    board = Board.new
    board.move(:c, "x")

    is_valid = board.is_valid?(:r)

    expect(is_valid).to be true
  end

  it 'returns false for a move that does not exist' do
    board = Board.new

    is_valid = board.is_valid?(:A)

    expect(is_valid).to be false
  end

  it 'returns false for a move that has already been made' do
    board = Board.new
    board.move(:tr, "x")

    is_valid = board.is_valid?(:tr)

    expect(is_valid).to be false
  end
end


describe 'move_exists?' do
  it 'returns true for move "t"' do
    board = Board.new

    move_exists = board.move_exists?(:t)

    expect(move_exists).to be true
  end

  it 'returns false for move "x"' do
    board = Board.new

    move_exists = board.move_exists?(:x)

    expect(move_exists).to be false
  end
end


describe 'position_is_empty?' do
  it 'returns true for an empty position' do
    board = Board.new
    board.move(:l, "x")
    board.move(:c, "o")

    position_is_empty = board.position_is_empty?(:t)

    expect(position_is_empty).to be true
  end

  it 'returns false for a position that was taken' do
    board = Board.new
    board.move(:r, "x")

    position_is_empty = board.position_is_empty?(:r)

    expect(position_is_empty).to be false
  end
end
