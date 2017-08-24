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
    true
  end
end
