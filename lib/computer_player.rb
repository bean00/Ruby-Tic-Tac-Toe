class ComputerPlayer < Player

  def initialize(player_num, board)
    @board = board
  end

  def get_next_move
    available_moves = @board.get_available_moves

    available_moves[0].to_s
  end

  def get_token
    "O"
  end

end
