require 'io_handler'

class Controller
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
  end

  def play_game
    IOHandler.display_introduction
    IOHandler.display_instructions

    has_player_won = false
    move_number = 1

    while (!has_player_won) && (move_number <= 9)
      player_num = set_player_num_based_on_move(move_number)
      play_round(player_num)

      player_char = set_player_char(player_num)
      has_player_won = ScoreTracker.has_player_won(board.board, player_char)

      move_number += 1
    end

    IOHandler.display_game_over_msg(move_number, player_num)
  end


  def play_round(player_num)
    IOHandler.prompt_player_for_move(player_num)
    move = IOHandler.get_move

    player_char = set_player_char(player_num)
    board.move(move, player_char)
    
    puts (board.to_string + "\n" +
          "\n")
  end

  private

  def set_player_num_based_on_move(move_number)
    (move_number % 2 != 0) ? 1 : 2
  end
  
  def set_player_char(player_num)
    (player_num == 1) ? "x" : "o"
  end

end
