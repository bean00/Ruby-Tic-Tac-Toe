class ScoreTracker

  def initialize(board)
    @board = board
  end

  def has_player_won(character)
    rows = extract_rows

    return are_any_rows_full(rows, character)
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