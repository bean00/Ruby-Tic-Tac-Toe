class Board
  @board = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
  ]

  def self.move(position)
    @board[0][1] = "x"
    @board
  end
end
