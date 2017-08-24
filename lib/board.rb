class Board
  attr_reader :board

  def initialize(board=Array.new(9, ""))
    @board = board
    @moves = { :tl => 0, :t => 1, :tr => 2,
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

=begin
  def has_player_won(character)
    rows = extract_rows

    return are_any_rows_full(rows, character)
  end
=end

  def extract_rows
    top_row = @board[0, 3]
    middle_row = @board[3, 3]
    bottom_row = @board[6, 3]
    [top_row, middle_row, bottom_row]
  end

  def are_any_rows_full(rows, character)
    is_a_row_full = false
    rows.each do |row|
      if is_row_full(row, character)
        is_a_row_full = true
      end
    end
    is_a_row_full
  end

  def is_row_full(row, character)
    return (row.count(character) == 3)
  end 

end
