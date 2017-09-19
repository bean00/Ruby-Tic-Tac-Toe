require_relative 'board_tracker'

class ComputerPlayer < Player

  def initialize(player_num, board_array)
    @board_array = board_array
    @board_tracker = BoardTracker.new(@board_array)
  end

  def get_next_move
    available_moves = @board_tracker.get_available_moves

    available_moves[0].to_s
  end

  def get_token
    "O"
  end
  
end
