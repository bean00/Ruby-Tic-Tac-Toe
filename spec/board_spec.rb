require 'board'

describe 'move' do
  [["top left", "tl", ["x", "",  "",
                         "",  "",  "",
                         "",  "",  ""]],
   ["top", "t", ["",  "x", "",
                 "",  "",  "",
                 "",  "",  ""]],
   ["bottom right", "br", ["",  "",  "",
                           "",  "",  "",
                           "",  "",  "x"]]
  ].each do |position, short_position, board_after_move|
    it "moves to the #{position} position" do
      board = Board.new

      board.move(short_position, "x")

      expect(board.board).to eq(board_after_move)
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
    board_after_moves = ["", "",  "",
                         "", "x", "",
                         "", "",  ""]

    board.move("c", "x")
    board.move("c", "o")
    
    expect(board.board).to eq(board_after_moves)
  end

  it "doesn't move where the same player has already gone" do
    board = Board.new
    board_after_moves = ["", "o", "",
                         "", "x", "",
                         "", "",  ""]

    board.move("c", "x")
    board.move("t", "o")
    board.move("c", "x")

    expect(board.board).to eq(board_after_moves)
  end

  it "doesn't allow a player to move to an invalid position" do
    board = Board.new
    board_after_move = ["", "", "",
                        "", "", "",
                        "", "", ""]

    board.move("XX", "x")

    expect(board.board).to eq(board_after_move)
  end
end


describe 'to_string' do
  it 'returns a formatted board if all positions are "x"s' do
    board = Board.new
    board.move("tl", "x")
    board.move("t", "x")
    board.move("tr", "x")
    board.move("l", "x")
    board.move("c", "x")
    board.move("r", "x")
    board.move("bl", "x")
    board.move("b", "x")
    board.move("br", "x")
    formatted_board = " x | x | x \n" +
                      "---+---+---\n" +
                      " x | x | x \n" + 
                      "---+---+---\n" +
                      " x | x | x "

    expect(board.to_string).to eq(formatted_board)
  end

  it 'returns a formatted board if all positions are empty' do
    board = Board.new
    formatted_board = "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   "

    expect(board.to_string).to eq(formatted_board)
  end

  it 'returns a formatted board if positions are mixed' do
    board = Board.new
    board.move("c", "x")
    board.move("tl", "o")
    board.move("br", "x")
    board.move("r", "o")
    formatted_board = " o |   |   \n" +
                      "---+---+---\n" +
                      "   | x | o \n" +
                      "---+---+---\n" +
                      "   |   | x "

    expect(board.to_string).to eq(formatted_board)
  end
end



