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
    st = ScoreTracker.new
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

  it 'returns true when the left column is filled' do
    board = Board.new
    board.move("tl", "x")
    board.move("l", "x")
    board.move("bl", "x")
    st = ScoreTracker.new(board.board)
    expect(st.has_player_won("x")).to be true
  end

  it 'returns true when the middle column is filled' do
    board = Board.new
    board.move("t", "x")
    board.move("c", "x")
    board.move("b", "x")
    st = ScoreTracker.new(board.board)
    expect(st.has_player_won("x")).to be true
  end

  it 'returns true when the right column is filled' do
    board = Board.new
    board.move("tr", "x")
    board.move("r", "x")
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
    st = ScoreTracker.new
    rows = [["", "", ""],
            ["", "", ""],
            ["", "", ""]]
    expect(st.extract_rows).to eq rows
  end
end


describe 'extract_columns' do
  it 'returns all columns for a board with 4 moves' do
    board = Board.new
    board.move("l", "x")
    board.move("bl", "o")
    board.move("t", "x")
    board.move("tr", "o")
    st = ScoreTracker.new(board.board)

    columns = [["",  "x", "o"],
               ["x", "",  ""],
               ["o", "",  ""]]

    expect(st.extract_columns).to eq columns
  end
end


describe 'are_any_arrays_full' do
  it 'returns true if one array is full' do
    st = ScoreTracker.new
    arrays = [["x", "x", "x"],
              ["",  "",  ""],
              ["",  "",  ""]]
    expect(st.are_any_arrays_full(arrays, "x")).to be true
  end

  it 'returns false if no array is full' do
    st = ScoreTracker.new
    arrays = [["x", "",  ""],
              ["",  "",  ""],
              ["x", "x", "o"]]
    expect(st.are_any_arrays_full(arrays, "x")).to be false
  end
end


describe 'is_array_full' do
  it 'returns true if the row is full' do
    st = ScoreTracker.new
    row = ["x", "x", "x"]
    expect(st.is_array_full(row, "x")).to be true
  end

  it 'returns false if the row is empty' do
    st = ScoreTracker.new
    row = ["", "", ""]
    expect(st.is_array_full(row, "x")).to be false
  end

  it 'returns false if the row has mixed characters' do
    st = ScoreTracker.new
    row = ["x", "o", "x"]
    expect(st.is_array_full(row, "x")).to be false
  end
end

