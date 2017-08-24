class ScoreTracker

  def initialize(board=Array.new(9, ""))
    @board = board
  end

  def has_player_won(character)
    has_won = false

    rows = extract_rows
    if are_any_rows_full(rows, character)
      has_won = true
    end

    left_col = @board[0] + @board[3] + @board[6]
    middle_col = @board[1] + @board[4] + @board[7]
    if is_array_full(left_col, character) || is_array_full(middle_col, character)
      has_won = true
    end

    return has_won
  end

  def extract_rows
    top_row = @board[0, 3]
    middle_row = @board[3, 3]
    bottom_row = @board[6, 3]
    [top_row, middle_row, bottom_row]
  end

  def are_any_rows_full(rows, character)
    is_a_row_full = false
    rows.each do |row|
      if is_array_full(row, character)
        is_a_row_full = true
      end
    end
    is_a_row_full
  end

  def is_array_full(array, character)
    return (array.count(character) == 3)
  end

end
