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

  it 'moves to 2 next' do
    board_before_move = ["x", "", "",
                         "",  "", "",
                         "",  "", ""]
    board_after_move = ["x", "x", "",
                        "",  "",  "",
                        "",  "",  ""]
    
    board = Board.new(board_before_move)
    board.move(2)

    expect(board.board).to eq(board_after_move)
  end
end
