require_relative 'win_checker'
require_relative 'score_tracker'

class ComputerPlayer < Player

  def initialize(player_num, side_length)
    @player_num = player_num
    @next_move = 0
    @side_length = side_length
    @comp_token = "O"
    @other_token = "X"
  end

  def get_next_move(board)
    minimax_score(board.to_string_array, @player_num)

    @next_move.to_s
  end

  def get_token
    @comp_token
  end

  private

  def minimax_score(board_string_array, next_player)
    current_board = Board.new(@side_length)
    current_board.set_board(board_string_array)
    score_tracker = ScoreTracker.new(current_board)

    player_that_just_went = (next_player == 1) ? 2 : 1

    player_that_just_went_token = get_player_token(player_that_just_went) 
    score_tracker.update_scores(player_that_just_went_token,
                                current_board.number_of_moves_left)

    current_score = score_tracker.get_player_score(@comp_token)

    if score_tracker.is_game_finished?
      return current_score
    else
      possible_moves = current_board.get_available_moves
      
      board_array = Array.new
      possible_moves.length.times {
        board = Board.new(@side_length)
        board.set_board(board_string_array)
        board_array << board 
      }

      scores = Array.new
      moves = Array.new

      possible_moves.each_with_index { |move, i| 
        next_player_token = get_player_token(next_player)
        board_array[i].move(move, next_player_token)
        new_board_state = board_array[i].to_string_array

        scores << minimax_score(new_board_state, player_that_just_went)
        moves << move
      }

      score = (next_player == @player_num) ? scores.max : scores.min

      index = scores.find_index(score)

      @next_move = moves[index]
      return score
    end
  end

  def get_player_token(player)
    if player == @player_num
      @comp_token
    else
      @other_token
    end
  end

end
