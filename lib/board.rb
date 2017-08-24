class Board
  attr_reader :board

  def initialize(board=Array.new(9, ""))
    @board = board
    @moves = { :ul => 0, :t => 1, :ur => 2,
               :l  => 3, :c => 4, :r  => 5,
               :bl => 6, :b => 7, :br => 8 }
  end

  def move(position_string, character)
    position = position_string.to_sym
    index = @moves[position]
    if is_valid(position)
      @board[index] = character
    end
    @board
  end

  def is_valid(move_symbol)
    return move_exists(move_symbol) && position_is_empty(move_symbol)
  end

  def move_exists(move_symbol)
    return (@moves.has_key?(move_symbol))
  end

  def position_is_empty(move_symbol)
    move_index = @moves[move_symbol]
    return (@board[move_index] == "")
  end


  def has_player_won(character)
    top_row = @board[0, 3]
    middle_row = @board[3, 3]
    bottom_row = @board[6, 3]
    return is_row_full(top_row, character)    ||
           is_row_full(middle_row, character) ||
           is_row_full(bottom_row, character)
  end

  def is_row_full(row, character)
    return (row.count(character) == 3)
  end 

end
