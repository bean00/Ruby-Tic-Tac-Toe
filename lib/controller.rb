require_relative 'io_handler'
require_relative 'input_validator'
require_relative 'view'
require_relative 'player'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'win_checker'

class Controller

  def initialize(board)
    @handler = IOHandler.new
    @board = board
    @view = View.new(@board.to_string_array)
  end

  def play_game
    @handler.display_intro_and_instructions
    game_mode = @handler.get_valid_game_mode
    has_quit = (game_mode == "q")
    a_player_has_won = false
    
    if !has_quit
      playing_computer = is_playing_computer?(game_mode)
      @handler.display_game_instructions(playing_computer)

      is_game_finished = false
      tokens = ["X", "O"]
      @board.set_tokens_before_any_move_is_made(tokens)
      @score_tracker = ScoreTracker.new(@board)

      x_token = tokens[0]
      o_token = tokens[1]

      @main_user = HumanPlayer.new(x_token, @handler)
      @other_player = set_other_player(x_token, o_token, playing_computer)
      players = { x_token => @main_user, o_token => @other_player }
      player = @other_player


      while (!is_game_finished && !has_quit)
        player_token = (player.get_token == x_token) ? o_token : x_token 
        player = players[player_token]
        move = play_round(player, playing_computer)

        @score_tracker.update_scores(player_token)
        
        is_game_finished = @score_tracker.is_game_finished?
        has_quit = (move == "q")
      end

      a_player_has_won = @score_tracker.has_either_player_won?
    end

    @handler.display_game_over_msg(a_player_has_won, has_quit, 
                                   playing_computer, player_token)
  end

  def play_round(player, playing_computer)
    player_token = player.get_token
    @handler.display_move_output(player_token, playing_computer)
    move = player.get_next_move(@board)

    if move == "q"
      return move
    end

    move = move.to_i
    @board.move(move, player_token)

    @view.update_view(@board.to_string_array)
    @view.display_board
  end

  private

  def is_playing_computer?(game_mode)
    game_mode == "c"
  end

  def set_other_player(x_token, o_token, playing_computer)
    if playing_computer
      ComputerPlayer.new(o_token, x_token, @score_tracker)
    else
      HumanPlayer.new(o_token, @handler)
    end
  end

end
