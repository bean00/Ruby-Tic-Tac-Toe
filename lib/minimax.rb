require 'deep_clone'

class Minimax

  def initialize(token, other_token, score_tracker)
    @token = token
    @other_token = other_token
    @score_tracker = score_tracker
  end

  def minimax_move_and_score(board, next_player_token)
    previous_player_token = (next_player_token == @token) ? @other_token : @token

    @score_tracker.update_scores(previous_player_token, board)

    score = @score_tracker.get_player_score(@token)

    if @score_tracker.is_game_finished?
      { move: 0, score: score }
    else
      possible_moves = board.get_available_moves

      moves = Array.new
      scores = Array.new

      possible_moves.each { |move|
        cloned_board = DeepClone.clone(board) 
        cloned_board.move(move, next_player_token)

        score = minimax_move_and_score(cloned_board,
                                       previous_player_token)[:score]

        moves << move
        scores << score
      }

      score = (next_player_token == @token) ? scores.max : scores.min

      index = scores.find_index(score)

      next_move = moves[index]

      { move: next_move, score: score }
    end
  end

end
