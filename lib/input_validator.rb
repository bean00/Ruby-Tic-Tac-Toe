class InputValidator

  def initialize(board_string_array)
    @board_string_array = board_string_array
    @num_positions = board_string_array.length
  end

  def is_move_valid?(move_str)
    if !only_contains_digits?(move_str)
      false
    else
      move_int = move_str.to_i

      (move_int >= 1) && (move_int <= @num_positions)
    end
  end

  def is_position_empty?(move)
    move = move.to_i

    move_index = move - 1
    
    @board_string_array[move_index] == ""
  end

  private

  def only_contains_digits?(string)
    string.scan(/\D/).empty?
  end

end
