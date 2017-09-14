require 'colorize'

class View

  def initialize(board_string_array)
    @board_string_array = board_string_array
  end

  def display_board
    formatted_board = ""

    @board_string_array.each_with_index do |pos, i|
      pos = convert_index_if_position_is_empty(pos, i)

      if pos == "X"
        pos = pos.colorize(:green) 
      elsif pos == "O"
        pos = pos.colorize(:red)
      end

      formatted_board << pad_with_spaces(pos)
      formatted_board << add_divider(i)
    end

    puts formatted_board + "\n" +
      "\n"
  end

  def update_view(board_string_array)
    @board_string_array = board_string_array
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
#    char.center(3)
    " " + char + " "
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
