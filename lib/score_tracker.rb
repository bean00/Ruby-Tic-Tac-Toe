class ScoreTracker

  def initialize(board=Array.new(9, ""))
    @board = board
  end

  def has_player_won(character)
    has_won = false

    rows = extract_rows
    if are_any_arrays_full(rows, character)
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

  def are_any_arrays_full(arrays, character)
    is_an_array_full = false
    arrays.each do |array|
      if is_array_full(array, character)
        is_an_array_full = true
      end
    end
    is_an_array_full
  end

  def is_array_full(array, character)
    return (array.count(character) == 3)
  end

end
