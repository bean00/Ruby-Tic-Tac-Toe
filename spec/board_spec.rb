require 'board'

describe 'move' do
  it 'moves to position 1' do
    move_at_1 = ["x", "", "", "", "", "", "", "", ""]
    board = Board.new
    expect(board.move(1)).to eq(move_at_1)
  end

  it 'moves to position 2' do
    move_at_2 = ["", "x", "", "", "", "", "", "", ""]
    board = Board.new
    expect(board.move(2)).to eq(move_at_2)
  end
end
