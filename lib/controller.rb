require_relative 'io_handler'

class Controller
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
  end

  def play_game
    IOHandler.display_introduction
    IOHandler.display_game_mode_instructions

    game_mode_character = IOHandler.get_user_input_for_game_mode
    playing_computer = is_playing_computer?(game_mode_character)

    IOHandler.display_game_mode(playing_computer)
    IOHandler.display_who_goes_1st(playing_computer)

    IOHandler.display_instructions

    has_player_won = false
    move_number = 1
    num_available_moves = board.get_available_moves.length

    while (!has_player_won) && (num_available_moves > 0)
      player_token = set_player_token_based_on_move(move_number)
      play_round(player_token, playing_computer)

      has_player_won = ScoreTracker.has_player_won?(board.board, player_token)

      move_number += 1
      num_available_moves = board.get_available_moves.length
    end

    IOHandler.display_game_over_msg(has_player_won, playing_computer, player_token)
  end

  def play_round(player_token, playing_computer)
    if player_token == "x"
      IOHandler.prompt_player_for_move(player_token, playing_computer)
      move = get_valid_move
    else
      if !playing_computer
        IOHandler.prompt_player_for_move(player_token, playing_computer)
        move = get_valid_move
      else
        print "The computer moved.\n"
        available_moves = board.get_available_moves
        move = available_moves[0]
      end
    end

    board.move(move, player_token)
    
    puts (board.to_string + "\n" +
          "\n")
  end

  private

  def get_valid_move
    move = IOHandler.get_user_input
    move_does_not_exist = !board.move_exists?(move)
    move_has_been_taken = !board.position_is_empty?(move)

    while move_does_not_exist || move_has_been_taken
      if move_does_not_exist
        print "\n<!> Error: Move \"#{move}\" doesn't exist.\n"
        print "Please enter a move that exists (ex: \"tl\", \"c\"): "
        move = IOHandler.get_user_input
        move_does_not_exist = !board.move_exists?(move)
        move_has_been_taken = !board.position_is_empty?(move)
      elsif move_has_been_taken
        print "\n<!> Error: The position at \"#{move}\" has already been taken.\n"
        print "Please enter a new move: "
        move = IOHandler.get_user_input
        move_does_not_exist = !board.move_exists?(move)
        move_has_been_taken = !board.position_is_empty?(move)
      end
    end

    move
  end

  def is_playing_computer?(game_mode_char)
    game_mode_char == "c"
  end

  def set_player_token_based_on_move(move_number)
    (move_number % 2 != 0) ? "x" : "o"
  end

end
