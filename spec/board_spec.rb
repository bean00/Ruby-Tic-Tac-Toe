require 'board'

describe 'move' do
  it 'moves to position 1' do
    move_at_1 = ["x", "", "", "", "", "", "", "", ""]
    expect(Board.move(1)).to eq(move_at_1)
  end
end
