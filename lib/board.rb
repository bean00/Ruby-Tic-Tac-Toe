class Board

  def initialize(board=Array.new(9, ""))
    @board = board
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

  def position_is_empty?(move)
    if move.is_a? String
      move = move.to_i
    end

    move_index = move - 1
    
    @board[move_index] == ""
  end

  def to_string
    @board
  end

end
