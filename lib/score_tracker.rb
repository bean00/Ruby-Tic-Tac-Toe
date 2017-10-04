class ScoreTracker
  WIN_SCORE = 1
  LOSS_SCORE = -1
  DRAW_SCORE = 0
  INCOMPLETE_GAME = -1000000

  def initialize(player_num, player_token, board)
    rules = TicTacToeRules.new(board.get_side_length)
    @win_checker = WinChecker.new(board, rules)
    @player_tokens = set_player_tokens(player_num, player_token, board)
    @player_scores = initialize_player_scores(@player_tokens)
  end

  def get_player_score(player_num)
    token = get_token_from_player_num(player_num)
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
  
  def update_scores(player_num, number_of_moves_left)
    token = get_token_from_player_num(player_num)

    if @win_checker.has_player_won?(token)
      set_player_scores_if_player_won(token)
    elsif number_of_moves_left == 0
      set_player_scores_if_player_drew(token)
    end
  end

  private

  def set_player_tokens(player_num, player_token, board)
    player_tokens = board.get_player_tokens

    token_is_at_correct_index = player_tokens[player_num - 1] == player_token

    if token_is_at_correct_index
      player_tokens
    else
      player_tokens.reverse
    end
  end

  def initialize_player_scores(player_tokens)
    player_1_token = player_tokens[0]
    player_2_token = player_tokens[1]
    { player_1_token => INCOMPLETE_GAME, player_2_token => INCOMPLETE_GAME }
  end

  def get_token_from_player_num(player_num)
    @player_tokens[player_num - 1]
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
