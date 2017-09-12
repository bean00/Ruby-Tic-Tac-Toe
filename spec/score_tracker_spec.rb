require 'board'
require 'score_tracker'

describe 'has_player_won?' do
  it 'returns true when the top row is filled' do
    board = Board.new
    board.move(1, "X")
    board.move(2, "X")
    board.move(3, "X")

    player_won = ScoreTracker.has_player_won?(board.to_string, "X")

    expect(player_won).to be true
  end

  it 'returns false when the board is empty' do
    board = Board.new

    player_won = ScoreTracker.has_player_won?(board.to_string, "X")

    expect(player_won).to be false
  end

  it 'returns true when the middle row is filled' do
    board = Board.new
    board.move(4, "O")
    board.move(5, "O")
    board.move(6, "O")

    player_won = ScoreTracker.has_player_won?(board.to_string, "O")

    expect(player_won).to be true
  end

  it 'returns true when the bottom row is filled' do
    board = Board.new
    board.move(7, "X")
    board.move(8, "X")
    board.move(9, "X")

    player_won = ScoreTracker.has_player_won?(board.to_string, "X")

    expect(player_won).to be true
  end

  it 'returns true when the left column is filled' do
    board = Board.new
    board.move(1, "X")
    board.move(4, "X")
    board.move(7, "X")

    player_won = ScoreTracker.has_player_won?(board.to_string, "X")

    expect(player_won).to be true
  end

  it 'returns true when the middle column is filled' do
    board = Board.new
    board.move(2, "X")
    board.move(5, "X")
    board.move(8, "X")

    player_won = ScoreTracker.has_player_won?(board.to_string, "X")

    expect(player_won).to be true
  end

  it 'returns true when the right column is filled' do
    board = Board.new
    board.move(3, "X")
    board.move(6, "X")
    board.move(9, "X")
    
    player_won = ScoreTracker.has_player_won?(board.to_string, "X")

    expect(player_won).to be true
  end

  it 'returns true when the diagonal from the "tl" to "br" is filled' do
    board = Board.new
    board.move(1, "X")
    board.move(5, "X")
    board.move(9, "X")

    player_won = ScoreTracker.has_player_won?(board.to_string, "X")

    expect(player_won).to be true
  end

  it 'returns true when the diagonal from the "tr" to "bl" is filled' do
    board = Board.new
    board.move(3, "X")
    board.move(5, "X")
    board.move(7, "X")

    player_won = ScoreTracker.has_player_won?(board.to_string, "X")
    
    expect(player_won).to be true
  end
end


