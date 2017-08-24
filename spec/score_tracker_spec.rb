require 'board'
require 'score_tracker'

describe 'has_player_won' do
  it 'returns true when the top row is filled' do
    board = Board.new
    board.move("tl", "x")
    board.move("t", "x")
    board.move("tr", "x")
    st = ScoreTracker.new(board.board)

    expect(st.has_player_won("x")).to be true
  end

  it 'returns false when the board is empty' do
    board = Board.new
    st = ScoreTracker.new(board.board)
    expect(st.has_player_won("x")).to be false
  end

  it 'returns true when the middle row is filled' do
    board = Board.new
    board.move("l", "o")
    board.move("c", "o")
    board.move("r", "o")
    st = ScoreTracker.new(board.board)
    expect(st.has_player_won("o")).to be true
  end

  it 'returns true when the bottom row is filled' do
    board = Board.new
    board.move("bl", "x")
    board.move("b", "x")
    board.move("br", "x")
    st = ScoreTracker.new(board.board)
    expect(st.has_player_won("x")).to be true
  end
end


describe 'extract_rows' do
  it 'returns all rows for a board with 3 moves' do
    board = Board.new
    board.move("tl", "x")
    board.move("c", "o")
    board.move("bl", "x")
    st = ScoreTracker.new(board.board)

    rows = [["x", "",  ""],
            ["",  "o", ""],
            ["x", "",  ""]]

    expect(st.extract_rows).to eq rows
  end

  it 'returns all rows for an empty board' do
    board = Board.new
    st = ScoreTracker.new(board.board)
    rows = [["", "", ""],
            ["", "", ""],
            ["", "", ""]]
    expect(st.extract_rows).to eq rows
  end
end


describe 'are_any_rows_full' do
  it 'returns true if one row is full' do
    board = Board.new
    st = ScoreTracker.new(board.board)
    rows = [["x", "x", "x"],
            ["",  "",  ""],
            ["",  "",  ""]]
    expect(st.are_any_rows_full(rows, "x")).to be true
  end

  it 'returns false if no row is full' do
    board = Board.new
    st = ScoreTracker.new(board.board)
    rows = [["x", "",  ""],
            ["",  "",  ""],
            ["x", "x", "o"]]
    expect(st.are_any_rows_full(rows, "x")).to be false
  end
end


describe 'is_row_full' do
  it 'returns true if the row is full' do
    board = Board.new
    st = ScoreTracker.new(board.board)
    row = ["x", "x", "x"]
    expect(st.is_row_full(row, "x")).to be true
  end

  it 'returns false if the row is empty' do
    board = Board.new
    st = ScoreTracker.new(board.board)
    row = ["", "", ""]
    expect(st.is_row_full(row, "x")).to be false
  end

  it 'returns false if the row has mixed characters' do
    board = Board.new
    st = ScoreTracker.new(board.board)
    row = ["x", "o", "x"]
    expect(st.is_row_full(row, "x")).to be false
  end
end

