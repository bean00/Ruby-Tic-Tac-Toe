class ScoreTracker

  def self.has_player_won?(board, character)
    is_a_row_full?(board, character)      ||
    is_a_column_full?(board, character)   ||
    is_a_diagonal_full?(board, character)
  end

  # ----- private -----

  def self.is_a_row_full?(board, character)
    rows = extract_rows(board)

    are_any_arrays_full?(rows, character)
  end

  def self.extract_rows(board)
    top_row = board[0, 3]
    middle_row = board[3, 3]
    bottom_row = board[6, 3]

    [top_row, middle_row, bottom_row]
  end

  def self.are_any_arrays_full?(arrays, character)
    arrays.each do |array|
      if is_array_full?(array, character)
        return true
      end
    end

    false
  end

  def self.is_array_full?(array, character)
    array.count(character) == 3
  end

  def self.is_a_column_full?(board, character)
    columns = extract_columns(board)

    are_any_arrays_full?(columns, character)
  end

  def self.extract_columns(board)
    left_col = [board[0], board[3], board[6]]
    middle_col = [board[1], board[4], board[7]]
    right_col = [board[2], board[5], board[8]]

    [left_col, middle_col, right_col]
  end

  def self.is_a_diagonal_full?(board, character)
    diagonals = extract_diagonals(board)
    
    are_any_arrays_full?(diagonals, character)
  end

  def self.extract_diagonals(board)
    left_diagonal = [board[0], board[4], board[8]]
    right_diagonal = [board[2], board[4], board[6]]

    [left_diagonal, right_diagonal]
  end

  private_class_method :is_a_row_full?, :extract_rows, :are_any_arrays_full?,
    :is_array_full?, :is_a_column_full?, :extract_columns, :is_a_diagonal_full?,
    :extract_diagonals

end
