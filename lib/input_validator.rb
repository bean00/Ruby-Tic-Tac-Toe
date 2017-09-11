class InputValidator

  def initialize(num_positions)
    @num_positions = num_positions
  end

  def is_move_valid?(move_str)
    if !only_contains_digits?(move_str)
      return false
    else
      move_int = move_str.to_i

      (move_int >= 1) && (move_int <= @num_positions)
    end
  end

  private

  def only_contains_digits?(string)
    string.scan(/\D/).empty?
  end

end
