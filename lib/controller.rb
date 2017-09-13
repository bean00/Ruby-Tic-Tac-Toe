require_relative 'io_handler'
require_relative 'input_validator'
require_relative 'view'

class Controller

  def initialize(board = Board.new(3))
    @handler = IOHandler.new
    @board = board
    @view = View.new(@board.to_string_array)
  end

  def play_game
    @handler.display_intro_and_instructions
    game_mode = @handler.get_valid_game_mode
    playing_computer = is_playing_computer?(game_mode)
    @handler.display_game_instructions(playing_computer)

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

    @handler.display_game_over_msg(has_player_won, playing_computer, player_token)
  end

  def play_round(player_token, playing_computer)
    if player_token == "X"
      @handler.prompt_player_for_move(player_token, playing_computer)
      move = @handler.get_valid_move(@board.to_string_array)
    else
      if !playing_computer
        @handler.prompt_player_for_move(player_token, playing_computer)
        move = @handler.get_valid_move(@board.to_string_array)
      else
        @handler.display_computer_moved
        move = get_comp_move(@board.get_available_moves)
      end
    end

    @board.move(move, player_token)
    
    @view.update_view(@board.to_string_array)
    @view.display_board
  end

  private

  def is_playing_computer?(game_mode)
    game_mode == "c"
  end

  def set_player_token_based_on_move(move_number)
    (move_number % 2 != 0) ? "X" : "O"
  end

  def get_comp_move(available_moves)
    available_moves[0]
  end

end
