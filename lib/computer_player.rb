require_relative 'minimax'
require_relative 'player'
require 'deep_clone'

class ComputerPlayer < Player

  def initialize(token, other_token, score_tracker)
    @minimax = Minimax.new(token, other_token, score_tracker)
    @token = token
  end

  def get_next_move(board)
    move = @minimax.minimax_move_and_score(board, @token)[:move]

    move.to_s
  end

  def get_token
    @token
  end

end
