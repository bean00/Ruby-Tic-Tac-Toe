require 'board'

describe 'move' do
  [["upper left", "ul", ["x", "",  "",
                         "",  "",  "",
                         "",  "",  ""]],
   ["top", "t", ["",  "x", "",
                 "",  "",  "",
                 "",  "",  ""]],
   ["bottom right", "br", ["",  "",  "",
                           "",  "",  "",
                           "",  "",  "x"]]
  ].each do |move_as_string, move_as_short_str, board_after_move|
    it "moves to the #{move_as_string} position" do
      board = Board.new
      expect(board.move(move_as_short_str)).to eq(board_after_move)
    end
  end

  it 'moves to the top next' do
    board_before_move = ["x", "", "",
                         "",  "", "",
                         "",  "", ""]
    board_after_move = ["x", "x", "",
                        "",  "",  "",
                        "",  "",  ""]
    
    board = Board.new(board_before_move)
    board.move("t")

    expect(board.board).to eq(board_after_move)
  end
end
