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
  ].each do |position_as_string, position_as_short_str, board_after_move|
    it "moves to the #{position_as_string} position" do
      board = Board.new
      expect(board.move(position_as_short_str, "x")).to eq(board_after_move)
    end
  end

  it 'moves to the top next' do
    board_before_move = ["x", "", "",
                         "",  "", "",
                         "",  "", ""]
    board_after_move = ["x", "o", "",
                        "",  "",  "",
                        "",  "",  ""]
    
    board = Board.new(board_before_move)
    board.move("t", "o")

    expect(board.board).to eq(board_after_move)
  end

  it "doesn't move where the other player has already gone" do
    board = Board.new
    board.move("c", "x")
    board.move("c", "o")
    board_after_moves = ["", "",  "",
                         "", "x", "",
                         "", "",  ""]
    
    expect(board.board).to eq(board_after_moves)
  end

  it "doesn't move where the same player has already gone" do
    board = Board.new
    board.move("c", "x")
    board.move("t", "o")
    board.move("c", "x")
    board_after_moves = ["", "o", "",
                         "", "x", "",
                         "", "",  ""]

    expect(board.board).to eq(board_after_moves)
  end
end


describe 'is_valid' do
  it 'returns true for a valid first move' do
    board = Board.new
    expect(board.is_valid(:ul)).to be true
  end

  it 'returns true for a valid second move' do
    board = Board.new
    board.move("ul", "x")
    expect(board.is_valid(:t)).to be true
  end

  it 'returns false for an invalid second move' do
    board = Board.new
    board.move("c", "x")
    expect(board.is_valid(:c)).to be false
  end

  it 'returns false for an invalid move to "tl"' do
    board = Board.new
    expect(board.is_valid(:tl)).to be false
  end
end


describe 'move_exists' do
  it 'returns true for a move that exists' do
    board = Board.new
    expect(board.move_exists(:r)).to be true
  end

  it "returns false for a move that doesn't exist" do
    board = Board.new
    expect(board.move_exists(:m)).to be false
  end
end


describe 'position_is_empty' do
  it 'returns true if the position is empty' do
    board = Board.new
    expect(board.position_is_empty(:c)).to be true
  end

  it 'returns false if the position is taken' do
    board = Board.new
    board.move("c", "x")
    expect(board.position_is_empty(:c)).to be false
  end
end

