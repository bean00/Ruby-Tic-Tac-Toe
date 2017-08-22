class Board
  attr_reader :board

  def initialize
    @board = ["", "", "", "", "", "", "", "", ""]
  end

  def move(move)
    zero_based_move = move - 1
    board[zero_based_move] = "x"
    board
  end
end
