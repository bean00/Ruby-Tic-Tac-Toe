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


