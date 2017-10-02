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
      player_turn = 1

      main_user_turn = 1
      other_user_turn = (main_user_turn == 1) ? 2 : 1
      @main_user = HumanPlayer.new(main_user_turn, playing_computer)
      @other_player = set_other_player(playing_computer, other_user_turn, @board)
      players = create_players_array(main_user_turn, @main_user, @other_player)

      tokens = [players[0].get_token, players[1].get_token]
      @board.set_tokens_before_any_move_is_made(tokens)

      @score_tracker = ScoreTracker.new(@board)

      while (!is_game_finished && !has_quit)
        player = set_player(players, player_turn)
        player_token = player.get_token
        move = play_round(player, playing_computer)

        @score_tracker.update_scores(player_token, @board.number_of_moves_left)
        is_game_finished = @score_tracker.is_game_finished?

        player_turn = (player_turn == 1) ? 2 : 1
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

  def set_other_player(playing_computer, other_user_turn, board)
    if playing_computer
      ComputerPlayer.new(other_user_turn, board.get_side_length)
    else
      HumanPlayer.new(other_user_turn, false)
    end
  end

  def create_players_array(main_user_turn, main_user, other_player)
    players = Array.new(2)
    
    if main_user_turn == 1
      players[0] = main_user
      players[1] = other_player
    elsif main_user_turn == 2
      players[0] = other_player
      players[1] = main_user
    end

    players
  end

  def set_player(players, player_turn)
    players[player_turn - 1]
  end

end
