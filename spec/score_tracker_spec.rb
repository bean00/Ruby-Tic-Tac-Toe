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
end

