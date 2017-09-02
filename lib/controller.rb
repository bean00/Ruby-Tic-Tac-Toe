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
      player_num = set_player_num_based_on_move(move_number)
      play_round(player_num, playing_computer)

      player_char = set_player_char(player_num)
      has_player_won = ScoreTracker.has_player_won?(board.board, player_char)

      move_number += 1
      num_available_moves = board.get_available_moves.length
    end

    IOHandler.display_game_over_msg(move_number, player_num, playing_computer)
  end


  def play_round(player_num, playing_computer)
    if player_num == 1
      IOHandler.prompt_player_for_move(player_num, playing_computer)
      move = IOHandler.get_user_input
    else
      if !playing_computer
        IOHandler.prompt_player_for_move(player_num, playing_computer)
        move = IOHandler.get_user_input
      else
        print "The computer moved.\n"
        available_moves = board.get_available_moves
        move = available_moves[0]
      end
    end

    player_char = set_player_char(player_num)
    board.move(move, player_char)
    
    puts (board.to_string + "\n" +
          "\n")
  end

  private

  def is_playing_computer?(game_mode_char)
    game_mode_char == "c"
  end

  def set_player_num_based_on_move(move_number)
    (move_number % 2 != 0) ? 1 : 2
  end
  
  def set_player_char(player_num)
    (player_num == 1) ? "x" : "o"
  end

end
