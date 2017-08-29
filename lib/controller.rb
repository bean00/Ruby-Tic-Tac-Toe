class Controller
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
  end

  def play_game
    display_introduction
    display_instructions

    has_player_won = false
    move_number = 1

    while (!has_player_won) && (move_number <= 9)
      player_num = set_player_num_based_on_move(move_number)
      play_round(player_num)

      player_char = set_player_char(player_num)
      has_player_won = ScoreTracker.has_player_won(board.board, player_char)

      move_number += 1
    end

    display_game_over_message(move_number, player_num)
  end


  def play_round(player_num)
    prompt_player_for_move(player_num)
    move = get_move

    player_char = set_player_char(player_num)
    board.move(move, player_char)
    
    puts (board.to_string + "\n" +
          "\n")
  end

  def prompt_player_for_move(player_num)
    print "Player #{player_num}, please enter your move: "
  end

  def get_move
    $stdin.gets.chomp
  end


  private

  def display_introduction
    print "Hello! This is a Tic Tac Toe program.\n" + 
          "\n"
  end

  def display_instructions
    print "To enter a move, type:\n" +
          "- \"t\"   -> top\n" +
          "- \"c\"   -> center\n" +
          "- \"b\"   -> bottom\n" +
          "- \"l\"   -> left\n" +
          "- \"r\"   -> right\n" +
          "- \"tl\"  -> top left\n" +
          "- \"tr\"  -> top right\n" +
          "- \"bl\"  -> bottom left\n" +
          "- \"br\"  -> bottom right\n" +
          "\n" +
          " tl | t | tr \n" +
          "----+---+----\n" +
          " l  | c | r  \n" +
          "----+---+----\n" +
          " bl | b | br \n" +
          "\n"
  end

  def set_player_num_based_on_move(move_number)
    (move_number % 2 != 0) ? 1 : 2
  end
  
  def set_player_char(player_num)
    (player_num == 1) ? "x" : "o"
  end

  def display_game_over_message(move_number, player_num)
    if (move_number >= 9)
      display_draw_message
    else
      display_winning_message(player_num)
    end
  end

  def display_draw_message
    print "Game over. Resulted in a draw.\n"
  end

  def display_winning_message(player_num)
    print "Game over. Player #{player_num} won!\n"
  end

end
