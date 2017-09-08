require_relative 'io_handler'

class Controller
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
  end

  def play_game
    IOHandler.display_introduction
    IOHandler.display_game_mode_instructions
    game_mode_symbol = get_valid_game_mode
    playing_computer = is_playing_computer?(game_mode_symbol)
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

  def get_valid_game_mode
    print "> "

    mode = IOHandler.get_user_input
    mode_is_invalid = (mode != :h) && (mode != :c)

    while mode_is_invalid
      print "\n<!> Error: Invalid input for game mode.\n"
      print "Please enter a valid choice (\"h\", \"c\"): "
      mode = IOHandler.get_user_input
      mode_is_invalid = (mode != :h) && (mode != :c)
    end

    mode
  end

  def get_valid_move
    move = IOHandler.get_user_input
    move_is_invalid = !board.is_valid?(move)

    while move_is_invalid
      if !board.move_exists?(move)
        print "\n<!> Error: Move \"#{move}\" doesn't exist.\n"
        print "Please enter a move that exists (ex: \"tl\", \"c\"): "
        move = IOHandler.get_user_input
        move_is_invalid = !board.is_valid?(move)
      elsif !board.position_is_empty?(move)
        print "\n<!> Error: The position at \"#{move}\" has already been taken.\n"
        print "Please enter a new move: "
        move = IOHandler.get_user_input
        move_is_invalid = !board.is_valid?(move)
      end
    end

    move
  end

  def is_playing_computer?(game_mode_symbol)
    game_mode_symbol == :c
  end

  def set_player_token_based_on_move(move_number)
    (move_number % 2 != 0) ? "x" : "o"
  end

end
