class Board
  attr_reader :board

  def initialize
    @board = ["", "", "", "", "", "", "", "", ""]
  end

  def move(move)
    board[move - 1] = "x"
    board
  end
end
