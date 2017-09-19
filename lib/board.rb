class Board

  def initialize(side_length)
    @side_length = side_length
    @board = Array.new(@side_length * @side_length, "")
  end

  def move(move, player_token)
    move_index = move - 1

    @board[move_index] = player_token
  end

  def to_string_array
    @board
  end

  def set_board(board)
    @board = board
  end

end
