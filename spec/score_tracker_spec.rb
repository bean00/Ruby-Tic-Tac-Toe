require 'board'
require 'score_tracker'

describe 'has_player_won' do
  it 'returns true when the top row is filled' do
    board = Board.new
    board.move("tl", "x")
    board.move("t", "x")
    board.move("tr", "x")

    player_won = ScoreTracker.has_player_won(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns false when the board is empty' do
    board = Board.new

    player_won = ScoreTracker.has_player_won(board.board, "x")

    expect(player_won).to be false
  end

  it 'returns true when the middle row is filled' do
    board = Board.new
    board.move("l", "o")
    board.move("c", "o")
    board.move("r", "o")

    player_won = ScoreTracker.has_player_won(board.board, "o")

    expect(player_won).to be true
  end

  it 'returns true when the bottom row is filled' do
    board = Board.new
    board.move("bl", "x")
    board.move("b", "x")
    board.move("br", "x")

    player_won = ScoreTracker.has_player_won(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns true when the left column is filled' do
    board = Board.new
    board.move("tl", "x")
    board.move("l", "x")
    board.move("bl", "x")

    player_won = ScoreTracker.has_player_won(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns true when the middle column is filled' do
    board = Board.new
    board.move("t", "x")
    board.move("c", "x")
    board.move("b", "x")

    player_won = ScoreTracker.has_player_won(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns true when the right column is filled' do
    board = Board.new
    board.move("tr", "x")
    board.move("r", "x")
    board.move("br", "x")
    
    player_won = ScoreTracker.has_player_won(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns true when the diagonal from the "tl" to "br" is filled' do
    board = Board.new
    board.move("tl", "x")
    board.move("c", "x")
    board.move("br", "x")

    player_won = ScoreTracker.has_player_won(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns true when the diagonal from the "tr" to "bl" is filled' do
    board = Board.new
    board.move("tr", "x")
    board.move("c", "x")
    board.move("bl", "x")

    player_won = ScoreTracker.has_player_won(board.board, "x")
    
    expect(player_won).to be true
  end
end


describe 'is_a_row_full' do
  it 'returns true if a row is full' do
    board = Board.new
    board.move("bl", "x")
    board.move("b", "x")
    board.move("br", "x")

    row_is_full = ScoreTracker.is_a_row_full(board.board, "x")

    expect(row_is_full).to be true
  end
end


describe 'is_a_column_full' do
  it 'returns true if a column is full' do
    board = Board.new
    board.move("tr", "x")
    board.move("r", "x")
    board.move("br", "x")

    column_is_full = ScoreTracker.is_a_column_full(board.board, "x")

    expect(column_is_full).to be true
  end
end


describe 'is_a_diagonal_full' do
  it 'returns true if a diagonal is full' do
    board = Board.new
    board.move("tl", "x")
    board.move("c", "x")
    board.move("br", "x")

    diagonal_is_full = ScoreTracker.is_a_diagonal_full(board.board, "x")
    
    expect(diagonal_is_full).to be true
  end
end


describe 'extract_rows' do
  it 'returns all rows for a board with 3 moves' do
    board = Board.new
    board.move("tl", "x")
    board.move("c", "o")
    board.move("bl", "x")
    rows = [["x", "",  ""],
            ["",  "o", ""],
            ["x", "",  ""]]

    extracted_rows = ScoreTracker.extract_rows(board.board)
    
    expect(extracted_rows).to eq rows
  end
end


describe 'extract_columns' do
  it 'returns all columns for a board with 4 moves' do
    board = Board.new
    board.move("l", "x")
    board.move("bl", "o")
    board.move("t", "x")
    board.move("tr", "o")
    columns = [["",  "x", "o"],
               ["x", "",  ""],
               ["o", "",  ""]]

    extracted_columns = ScoreTracker.extract_columns(board.board)

    expect(extracted_columns).to eq columns
  end
end


describe 'extract_diagonals' do
  it 'returns all diagonals for a board with 3 moves' do
    board = Board.new
    board.move("c", "x")
    board.move("r", "o")
    board.move("br", "x")
    diagonals = [["", "x", "x"],
                 ["", "x", ""]]

    extracted_diagonals = ScoreTracker.extract_diagonals(board.board)

    expect(extracted_diagonals).to eq diagonals
  end
end


describe 'are_any_arrays_full' do
  it 'returns true if one array is full' do
    arrays = [["x", "x", "x"],
              ["",  "",  ""],
              ["",  "",  ""]]

    an_array_is_full = ScoreTracker.are_any_arrays_full(arrays, "x")

    expect(an_array_is_full).to be true
  end

  it 'returns false if no array is full' do
    arrays = [["x", "",  ""],
              ["",  "",  ""],
              ["x", "x", "o"]]

    an_array_is_full = ScoreTracker.are_any_arrays_full(arrays, "x")

    expect(an_array_is_full).to be false
  end
end


describe 'is_array_full' do
  it 'returns true if the row is full' do
    row = ["x", "x", "x"]

    array_is_full = ScoreTracker.is_array_full(row, "x")

    expect(array_is_full).to be true
  end

  it 'returns false if the row is empty' do
    row = ["", "", ""]

    array_is_full = ScoreTracker.is_array_full(row, "x")

    expect(array_is_full).to be false
  end

  it 'returns false if the row has mixed characters' do
    row = ["x", "o", "x"]

    array_is_full = ScoreTracker.is_array_full(row, "x")

    expect(array_is_full).to be false
  end
end

