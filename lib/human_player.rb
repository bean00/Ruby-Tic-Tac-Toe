require_relative 'io_handler'

class HumanPlayer < Player

  def initialize(player_num, board)
    @player_num = player_num
    @board = board
  end

  def get_next_move
    IOHandler.new.get_valid_move(@board.to_string_array)
  end

  def get_token
    if @player_num == 1
      "X"
    elsif @player_num == 2
      "O"
    end
  end

end
