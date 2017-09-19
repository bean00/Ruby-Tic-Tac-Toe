require_relative 'board_tracker'
require_relative 'io_handler'

class Player

  def initialize(playing_computer, player_num, board_array)
    @is_computer = playing_computer
    @player_num = player_num
    @board_array = board_array
    @board_tracker = BoardTracker.new(@board_array)
    @player_token = set_token
  end

  def get_next_move
    if @is_computer
      available_moves = @board_tracker.get_available_moves

      get_comp_move(available_moves).to_s
    else
      handler = IOHandler.new

      handler.get_valid_move(@board_array)
    end
  end

  def get_token
    @player_token
  end

  private

  def set_token
    if @is_computer
      "O"
    else
      if @player_num == 1
        "X"
      elsif @player_num == 2
        "O"
      end
    end
  end

  def get_comp_move(available_moves)
    available_moves[0]
  end

end
