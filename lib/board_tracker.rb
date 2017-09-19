class BoardTracker

  def initialize(board_string_array)
    @board_string_array = board_string_array
  end

  def get_available_moves
    available_moves = []

    @board_string_array.each_with_index do |pos, i|
      if pos == ""
        move = i + 1
        available_moves << move
      end
    end

    available_moves
  end

  def set_board_array(board_string_array)
    @board_string_array = board_string_array
  end

end
