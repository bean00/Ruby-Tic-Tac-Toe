require 'board'
require 'score_tracker'

describe 'has_player_won?' do
  it 'returns true when the top row is filled' do
    board = Board.new
    board.move(1, "x")
    board.move(2, "x")
    board.move(3, "x")

    player_won = ScoreTracker.has_player_won?(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns false when the board is empty' do
    board = Board.new

    player_won = ScoreTracker.has_player_won?(board.board, "x")

    expect(player_won).to be false
  end

  it 'returns true when the middle row is filled' do
    board = Board.new
    board.move(4, "o")
    board.move(5, "o")
    board.move(6, "o")

    player_won = ScoreTracker.has_player_won?(board.board, "o")

    expect(player_won).to be true
  end

  it 'returns true when the bottom row is filled' do
    board = Board.new
    board.move(7, "x")
    board.move(8, "x")
    board.move(9, "x")

    player_won = ScoreTracker.has_player_won?(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns true when the left column is filled' do
    board = Board.new
    board.move(1, "x")
    board.move(4, "x")
    board.move(7, "x")

    player_won = ScoreTracker.has_player_won?(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns true when the middle column is filled' do
    board = Board.new
    board.move(2, "x")
    board.move(5, "x")
    board.move(8, "x")

    player_won = ScoreTracker.has_player_won?(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns true when the right column is filled' do
    board = Board.new
    board.move(3, "x")
    board.move(6, "x")
    board.move(9, "x")
    
    player_won = ScoreTracker.has_player_won?(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns true when the diagonal from the "tl" to "br" is filled' do
    board = Board.new
    board.move(1, "x")
    board.move(5, "x")
    board.move(9, "x")

    player_won = ScoreTracker.has_player_won?(board.board, "x")

    expect(player_won).to be true
  end

  it 'returns true when the diagonal from the "tr" to "bl" is filled' do
    board = Board.new
    board.move(3, "x")
    board.move(5, "x")
    board.move(7, "x")

    player_won = ScoreTracker.has_player_won?(board.board, "x")
    
    expect(player_won).to be true
  end
end


