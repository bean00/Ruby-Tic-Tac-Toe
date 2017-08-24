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

describe 'is_valid' do
  it 'returns true for a valid first move' do
    board = Board.new
    expect(board.is_valid("ul")).to be true
  end

  it 'returns true for a valid second move' do
    board = Board.new
    board.move("ul")
    expect(board.is_valid("t")).to be true
  end

  it 'returns false for an invalid second move' do
    board = Board.new
    board.move("c")
    expect(board.is_valid("c")).to be false
  end

  it 'returns false for an invalid move to "tl"' do
    board = Board.new
    expect(board.is_valid("tl")).to be false
  end
end

describe 'does_move_exist' do
  it 'returns true for a move that exists' do
    board = Board.new
    expect(board.does_move_exist(:r)).to be true
  end

  it "returns false for a move that doesn't exist" do
    board = Board.new
    expect(board.does_move_exist(:m)).to be false
  end
end



