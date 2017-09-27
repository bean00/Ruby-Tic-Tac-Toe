require_relative 'win_checker'
require_relative 'score_tracker'

class ComputerPlayer < Player

  def initialize(player_num, board)
    @player_num = player_num
    @board = board
    @next_move = 0
    @side_length = board.get_side_length
  end

  def get_next_move
    minimax_score(@board.to_string_array, @player_num)

    @next_move.to_s
  end

  def get_token
    "O"
  end

  private

  def minimax_score(board_string_array, next_player)
    current_board = Board.new(@side_length)
    current_board.set_board(board_string_array)
    score_tracker = ScoreTracker.new(current_board)

    player_that_just_went = (next_player == 1) ? 2 : 1
    current_score = 0

  end

end
