require 'set'

class TicTacToeRules

  def initialize(side_length)
    @side_length = side_length
    @full_rows = create_full_row_sets
    @full_columns = create_full_column_sets
    @full_diagonals = create_full_diagonal_sets
  end

  def get_all_full_sets
    [@full_rows, @full_columns, @full_diagonals].flatten
  end

  def get_full_rows
    @full_rows
  end

  def get_full_columns
    @full_columns
  end

  def get_full_diagonals
    @full_diagonals
  end

  private

  def create_full_row_sets
    row_starting_positions = create_starting_positions(0, @side_length - 1, :row)

    create_row_or_col_sets_to_add(row_starting_positions, :row)
  end

  def create_starting_positions(start_val, end_val, set_type)
    start_array = []

    for i in start_val..end_val
      start_array << start_value_to_add(i, set_type)
    end

    start_array
  end

  def start_value_to_add(i, set_type)
    if set_type == :row
      1 + (i * @side_length)
    elsif set_type == :column
      i
    end
  end

  def create_row_or_col_sets_to_add(start_positions, set_type)
    full_sets = []

    start_positions.each do |start|
      set = Set.new

      for i in 0..(@side_length - 1)
        value_to_add = set_value_to_add(i, start, set_type)
        set.add(value_to_add)
      end

      full_sets << set
    end

    full_sets
  end

  def set_value_to_add(i, start, set_type)
    if set_type == :row
      start + i
    elsif set_type == :column
      start + (i * @side_length)
    end
  end

  def create_full_column_sets
    col_starting_positions = create_starting_positions(1, @side_length, :column)

    create_row_or_col_sets_to_add(col_starting_positions, :column)
  end


  def create_full_diagonal_sets
    full_diagonals = []

    full_diagonals << create_diagonal_set(:upper_left)

    full_diagonals << create_diagonal_set(:upper_right)
  end

  def create_diagonal_set(diagonal_type)
    diagonal = Set.new

    for i in 0..(@side_length - 1)
      value_to_add = diagonal_value_to_add(i, diagonal_type)
      diagonal.add(value_to_add)
    end

    diagonal
  end

  def diagonal_value_to_add(i, diagonal_type)
    if diagonal_type == :upper_left
      1 + i * (@side_length + 1)
    elsif diagonal_type == :upper_right
      @side_length + (i * (@side_length - 1))
    end
  end

end
