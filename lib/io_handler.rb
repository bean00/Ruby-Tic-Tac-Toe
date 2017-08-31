class IOHandler

  def self.display_introduction
    print "Hello! This is a Tic Tac Toe program.\n" +
          "\n"
  end

  def self.display_instructions
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

  def self.prompt_player_for_move(player_num)
    print "Player #{player_num}, please enter your move: "
  end

  def self.get_move
    $stdin.gets.chomp
  end

  def self.display_game_over_msg(move_number, player_num)
    if (move_number >= 9)
      display_draw_message
    else
      display_winning_message(player_num)
    end
  end

  # ----- private -----

  def self.display_draw_message
    print "Game over. Resulted in a draw.\n"
  end

  def self.display_winning_message(player_num)
    print "Game over. Player #{player_num} won!\n"
  end

  private_class_method :display_draw_message, :display_winning_message

end
