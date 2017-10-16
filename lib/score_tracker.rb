class ScoreTracker
  WIN_SCORE = 1
  LOSS_SCORE = -1
  DRAW_SCORE = 0
  INCOMPLETE_GAME = -1000000

  def initialize(win_checker, player_tokens)
    @win_checker = win_checker
    @player_tokens = player_tokens
    @player_scores = initialize_player_scores(@player_tokens)
  end

  def get_player_score(token)
    @player_scores[token]
  end

  def is_game_finished?
    player_1_token = @player_tokens[0]

    @player_scores[player_1_token] != INCOMPLETE_GAME
  end

  def has_either_player_won?
    player_1_token = @player_tokens[0]

    @player_scores[player_1_token] == WIN_SCORE ||
      @player_scores[player_1_token] == LOSS_SCORE
  end
  
  def update_scores(token, board = @board)
    reset_scores_if_they_were_changed

    set_player_scores(token, board)
  end

  private

  def initialize_player_scores(player_tokens)
    player_1_token = player_tokens[0]
    player_2_token = player_tokens[1]
    { player_1_token => INCOMPLETE_GAME, player_2_token => INCOMPLETE_GAME }
  end

  def reset_scores_if_they_were_changed
    if @player_scores[@player_tokens[0]] != INCOMPLETE_GAME
      @player_scores.each { |k, v| @player_scores[k] = INCOMPLETE_GAME }
    end
  end

  def set_player_scores(token, board)
    if @win_checker.has_player_won?(token, board)
      set_player_scores_if_player_won(token)
    elsif board.number_of_moves_left == 0
      set_player_scores_if_player_drew(token)
    end
  end

  def set_player_scores_if_player_won(token)
    other_token = get_other_token(token)
    @player_scores[token] = WIN_SCORE
    @player_scores[other_token] = LOSS_SCORE
  end

  def get_other_token(token)
    (@player_tokens[0] == token) ? @player_tokens[1] : @player_tokens[0]
  end

  def set_player_scores_if_player_drew(token)
    other_token = get_other_token(token)
    @player_scores[token] = DRAW_SCORE
    @player_scores[other_token] = DRAW_SCORE
  end

end
