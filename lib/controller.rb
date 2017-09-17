require_relative 'io_handler'
require_relative 'input_validator'
require_relative 'view'

class Controller

  def initialize(board = Board.new(3))
    @board = board
    @view = View.new(@board.to_string_array)
  end

  def play_game
    IOHandler.display_introduction
    IOHandler.display_game_mode_instructions
    game_mode = get_valid_game_mode
    playing_computer = is_playing_computer?(game_mode)
    IOHandler.display_game_mode(playing_computer)
    IOHandler.display_who_goes_1st(playing_computer)
    IOHandler.display_instructions

    has_player_won = false
    move_number = 1
    num_available_moves = @board.get_available_moves.length

    while (!has_player_won) && (num_available_moves > 0)
      player_token = set_player_token_based_on_move(move_number)
      play_round(player_token, playing_computer)

      has_player_won = ScoreTracker.has_player_won?(@board.to_string_array,
                                                    player_token)

      move_number += 1
      num_available_moves = @board.get_available_moves.length
    end

    IOHandler.display_game_over_msg(has_player_won, playing_computer, player_token)
  end

  def play_round(player_token, playing_computer)
    if player_token == "X"
      IOHandler.prompt_player_for_move(player_token, playing_computer)
      move = get_valid_move
    else
      if !playing_computer
        IOHandler.prompt_player_for_move(player_token, playing_computer)
        move = get_valid_move
      else
        print "The computer moved.\n"
        available_moves = @board.get_available_moves
        move = available_moves[0]
      end
    end

    @board.move(move, player_token)
    
    @view.update_view(@board.to_string_array)
    @view.display_board
  end

  private

  def get_valid_game_mode
    print "> "

    mode = IOHandler.get_user_input
    mode_is_invalid = (mode != "h") && (mode != "c")

    while mode_is_invalid
      print "\n<!> Error: Invalid input for game mode.\n"
      print "Please enter a valid choice (\"h\", \"c\"): "
      mode = IOHandler.get_user_input
      mode_is_invalid = (mode != "h") && (mode != "c")
    end

    mode
  end

  def get_valid_move
    move = IOHandler.get_user_input
    iv = InputValidator.new(9)

    while !iv.is_move_valid?(move) || !@board.position_is_empty?(move)
      if !iv.is_move_valid?(move)
        print "\n<!> Error: Move \"#{move}\" is invalid.\n"
        print "Please enter a move from 1-9: "
        move = IOHandler.get_user_input
      elsif !@board.position_is_empty?(move)
        print "\n<!> Error: Move #{move} has already been taken.\n"
        print "Please enter a new move: "
        move = IOHandler.get_user_input
      end
    end

    move.to_i
  end

  def is_playing_computer?(game_mode)
    game_mode == "c"
  end

  def set_player_token_based_on_move(move_number)
    (move_number % 2 != 0) ? "X" : "O"
  end

end
