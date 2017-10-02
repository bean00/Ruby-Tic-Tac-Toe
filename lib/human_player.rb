require_relative 'io_handler'

class HumanPlayer < Player

  def initialize(player_num, playing_computer)
    @player_num = player_num
    @playing_computer = playing_computer
  end

  def get_next_move(board)
    IOHandler.new.get_valid_move(board.to_string_array)
  end

  def get_token
    if @playing_computer
      "X"
    else
      if @player_num == 1
        "X"
      elsif @player_num == 2
        "O"
      end
    end
  end

end
