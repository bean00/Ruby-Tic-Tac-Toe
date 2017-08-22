class Board
  def self.move(move)
    board = Array.new(9, "")
    board[move - 1] = "x"
    board
  end
end
