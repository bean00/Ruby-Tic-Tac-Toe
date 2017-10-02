class ScoreTracker
  WIN_SCORE = 1
  LOSS_SCORE = -1
  DRAW_SCORE = 0
  INCOMPLETE_GAME = -1000000

  def initialize(board)
    rules = TicTacToeRules.new(board.get_side_length)
    @win_checker = WinChecker.new(board, rules)
    tokens = board.get_player_tokens
    @player_scores = initialize_player_scores(tokens[0], tokens[1])
    @player_tokens = [tokens[0], tokens[1]]
  end

  def get_player_score(token)
    @player_scores[token]
  end

  def is_game_finished?
    player_a_token = @player_tokens[0]

    @player_scores[player_a_token] != INCOMPLETE_GAME
  end

  def has_either_player_won?
    player_a_token = @player_tokens[0]

    @player_scores[player_a_token] == WIN_SCORE ||
    @player_scores[player_a_token] == LOSS_SCORE
  end
  
  def update_scores(token, number_of_moves_left)
    if @win_checker.has_player_won?(token)
      set_player_scores_if_player_won(token)
    elsif number_of_moves_left == 0
      set_player_scores_if_player_drew(token)
    end
  end

  private

  def initialize_player_scores(player_a_token, player_b_token)
    { player_a_token => INCOMPLETE_GAME, player_b_token => INCOMPLETE_GAME }
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
