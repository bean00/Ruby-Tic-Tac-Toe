require_relative 'player'
require 'deep_clone'

class ComputerPlayer < Player

  def initialize(token, other_token, score_tracker)
    @token = token
    @other_token = other_token
    @score_tracker = score_tracker
  end

  def get_next_move(board)
    move = minimax_score(board, @token)[:move]

    move.to_s
  end

  def get_token
    @token
  end

  private

  def minimax_score(board, next_player_token)
    previous_player_token = (next_player_token == @token) ? @other_token : @token

    @score_tracker.update_scores(previous_player_token, board)

    current_score = @score_tracker.get_player_score(@token)

    if @score_tracker.is_game_finished?
      return { move: 0, score: current_score }
    else
      possible_moves = board.get_available_moves
      
      moves_and_scores = Hash.new

      possible_moves.each_with_index { |move, i| 
        cloned_board = DeepClone.clone(board)
        cloned_board.move(move, next_player_token)

        score = minimax_score(cloned_board, previous_player_token)[:score]
        moves_and_scores[move] = score
      }

      scores = moves_and_scores.values
      score = (next_player_token == @token) ? scores.max : scores.min

      next_move = moves_and_scores.key(score)

      return { move: next_move, score: score }
    end
  end

end
