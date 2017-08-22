require 'board'

describe 'move' do
  [[1, ["x", "",  "",
        "",  "",  "",
        "",  "",  ""]],
   [2, ["",  "x", "",
        "",  "",  "",
        "",  "",  ""]],
   [9, ["",  "",  "",
        "",  "",  "",
        "",  "",  "x"]]
  ].each do |move, board_after_move|
    it "moves to position #{move}" do
      board = Board.new
      expect(board.move(move)).to eq(board_after_move)
    end
  end

  it 'moves to 1, then 2' do
    board_after_moves = ["x", "x", "", "", "", "", "", "", ""]
    board = Board.new
    board.move(1)
    board.move(2)
    expect(board.board).to eq(board_after_moves)
  end
end
