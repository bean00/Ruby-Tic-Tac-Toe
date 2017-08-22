class Board
  def self.move(move)
    board = ["", "", "", "", "", "", "", "", ""]
    board[move - 1] = "x"
    board
  end
end
