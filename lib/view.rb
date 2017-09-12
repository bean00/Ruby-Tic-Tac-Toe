class View

  def initialize(board_string)
    @board = board_string
  end

  def display_board
    formatted_board = ""

    @board.each_with_index do |pos, i|
      pos = convert_index_if_position_is_empty(pos, i)

      formatted_board << pad_with_spaces(pos)
      formatted_board << add_divider(i)
    end

    puts formatted_board + "\n" +
      "\n"
  end

  def update_view(board_string)
    @board = board_string
  end

  private

  def convert_index_if_position_is_empty(position, index)
    if position == ""
      return (index + 1).to_s
    else
      return position
    end
  end

  def pad_with_spaces(char)
    char.center(3)
  end

  def add_divider(index)
    divider = ""

    if ((index + 1) % 3 != 0)
      divider = "|"
    elsif index < 8
      divider = "\n---+---+---\n"
    end

    divider
  end

end
