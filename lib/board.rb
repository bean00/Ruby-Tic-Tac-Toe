class Board
  attr_reader :board

  def initialize(board=Array.new(9, ""))
    @board = board
    @moves = { :ul => 0, :t => 1, :ur => 2,
               :l  => 3, :c => 4, :r  => 5,
               :bl => 6, :b => 7, :br => 8 }
  end

  def move(move_string)
    move_symbol = move_string.to_sym
    move_index = @moves[move_symbol]
    @board[move_index] = "x"
    @board
  end

  def is_valid(move_symbol)
    if @moves.has_key?(move_symbol)
      move_index = @moves[move_symbol]
      return (@board[move_index] == "")
    else
      return false
    end
  end

  def does_move_exist(move_symbol)
    return (@moves.has_key?(move_symbol))
  end
end
