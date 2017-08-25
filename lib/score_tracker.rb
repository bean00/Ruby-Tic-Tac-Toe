class ScoreTracker

  def initialize(board=Array.new(9, ""))
    @board = board
  end

  def has_player_won(character)
    return is_a_row_full(character)      ||
           is_a_column_full(character)   ||
           is_a_diagonal_full(character)
  end

  def is_a_row_full(character)
    rows = extract_rows
    return (are_any_arrays_full(rows, character))
  end

  def is_a_column_full(character)
    columns = extract_columns
    return (are_any_arrays_full(columns, character))
  end

  def is_a_diagonal_full(character)
    left_diagonal = [@board[0], @board[4], @board[8]]
    right_diagonal = [@board[2], @board[4], @board[6]]
    diagonals = [left_diagonal, right_diagonal]
    return (are_any_arrays_full(diagonals, character))
  end

  def extract_rows
    top_row = @board[0, 3]
    middle_row = @board[3, 3]
    bottom_row = @board[6, 3]
    [top_row, middle_row, bottom_row]
  end

  def extract_columns
    left_col = [@board[0], @board[3], @board[6]]
    middle_col = [@board[1], @board[4], @board[7]]
    right_col = [@board[2], @board[5], @board[8]]
    [left_col, middle_col, right_col]
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
