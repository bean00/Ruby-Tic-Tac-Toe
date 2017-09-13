class Board

  def initialize(side_length)
    @side_length = side_length
    @board = Array.new(@side_length * @side_length, "")
  end

  def move(move, player_token)
    move_index = move - 1

    @board[move_index] = player_token
  end

  def get_available_moves
    available_moves = []

    @board.each_with_index do |pos, i|
      if pos == ""
        move = i + 1
        available_moves << move
      end
    end

    available_moves
  end

  def to_string_array
    @board
  end

  def set_board(board)
    @board = board
  end

end
