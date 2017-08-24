require 'board'

describe 'move' do
  [["upper left", "ul", ["x", "",  "",
                         "",  "",  "",
                         "",  "",  ""]],
   ["top", "t", ["",  "x", "",
                 "",  "",  "",
                 "",  "",  ""]],
   ["bottom right", "br", ["",  "",  "",
                           "",  "",  "",
                           "",  "",  "x"]]
  ].each do |position_as_string, position_as_short_str, board_after_move|
    it "moves to the #{position_as_string} position" do
      board = Board.new
      expect(board.move(position_as_short_str, "x")).to eq(board_after_move)
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
    board.move("t", "o")

    expect(board.board).to eq(board_after_move)
  end

  it "doesn't move where the other player has already gone" do
    board = Board.new
    board.move("c", "x")
    board.move("c", "o")
    board_after_moves = ["", "",  "",
                         "", "x", "",
                         "", "",  ""]
    
    expect(board.board).to eq(board_after_moves)
  end

  it "doesn't move where the same player has already gone" do
    board = Board.new
    board.move("c", "x")
    board.move("t", "o")
    board.move("c", "x")
    board_after_moves = ["", "o", "",
                         "", "x", "",
                         "", "",  ""]

    expect(board.board).to eq(board_after_moves)
  end

  it "doesn't allow a player to move to an invalid position" do
    board = Board.new
    board.move("XX", "x")
    board_after_move = ["", "", "",
                        "", "", "",
                        "", "", ""]

    expect(board.board).to eq(board_after_move)
  end
end


describe 'is_valid' do
  it 'returns true for a valid first move' do
    board = Board.new
    expect(board.is_valid(:ul)).to be true
  end

  it 'returns true for a valid second move' do
    board = Board.new
    board.move("ul", "x")
    expect(board.is_valid(:t)).to be true
  end

  it 'returns false for an invalid second move' do
    board = Board.new
    board.move("c", "x")
    expect(board.is_valid(:c)).to be false
  end

  it 'returns false for an invalid move to "tl"' do
    board = Board.new
    expect(board.is_valid(:tl)).to be false
  end
end


describe 'move_exists' do
  it 'returns true for a move that exists' do
    board = Board.new
    expect(board.move_exists(:r)).to be true
  end

  it "returns false for a move that doesn't exist" do
    board = Board.new
    expect(board.move_exists(:m)).to be false
  end
end


describe 'position_is_empty' do
  it 'returns true if the position is empty' do
    board = Board.new
    expect(board.position_is_empty(:c)).to be true
  end

  it 'returns false if the position is taken' do
    board = Board.new
    board.move("c", "x")
    expect(board.position_is_empty(:c)).to be false
  end
end


describe 'has_player_won' do
  it 'returns true when the top row is filled' do
    board = Board.new
    board.move("ul", "x")
    board.move("t", "x")
    board.move("ur", "x")
    expect(board.has_player_won("x")).to be true
  end

  it 'returns false when the board is empty' do
    board = Board.new
    expect(board.has_player_won("x")).to be false
  end

  it 'returns true when the middle row is filled' do
    board = Board.new
    board.move("l", "o")
    board.move("c", "o")
    board.move("r", "o")
    expect(board.has_player_won("o")).to be true
  end

  it 'returns true when the bottom row is filled' do
    board = Board.new
    board.move("bl", "x")
    board.move("b", "x")
    board.move("br", "x")
    expect(board.has_player_won("x")).to be true
  end
end


describe 'extract_rows' do
  it 'returns all rows for a board with 3 moves' do
    board = Board.new
    board.move("ul", "x")
    board.move("c", "o")
    board.move("bl", "x")

    rows = [["x", "",  ""],
            ["",  "o", ""],
            ["x", "",  ""]]

    expect(board.extract_rows).to eq rows
  end

  it 'returns all rows for an empty board' do
    board = Board.new
    rows = [["", "", ""],
            ["", "", ""],
            ["", "", ""]]
    expect(board.extract_rows).to eq rows
  end
end


describe 'are_any_rows_full' do
  it 'returns true if one row is full' do
    board = Board.new
    rows = [["x", "x", "x"],
            ["",  "",  ""],
            ["",  "",  ""]]
    expect(board.are_any_rows_full(rows, "x")).to be true
  end

  it 'returns false if no row is full' do
    board = Board.new
    rows = [["x", "",  ""],
            ["",  "",  ""],
            ["x", "x", "o"]]
    expect(board.are_any_rows_full(rows, "x")).to be false
  end
end


describe 'is_row_full' do
  it 'returns true if the row is full' do
    board = Board.new
    row = ["x", "x", "x"]
    expect(board.is_row_full(row, "x")).to be true
  end

  it 'returns false if the row is empty' do
    board = Board.new
    row = ["", "", ""]
    expect(board.is_row_full(row, "x")).to be false
  end

  it 'returns false if the row has mixed characters' do
    board = Board.new
    row = ["x", "o", "x"]
    expect(board.is_row_full(row, "x")).to be false
  end
end


