class IOHandler

  def self.display_introduction
    print "Hello! This is a Tic Tac Toe program.\n" +
          "\n"
  end

  def self.display_game_mode_instructions
    print "Please enter one of the following:\n" +
          "- \"h\" to play against another person\n" +
          "- \"c\" to play against a computer\n" +
          "\n"
  end

  def self.display_game_mode(playing_computer)
    if playing_computer
      print "\nOk, you chose to play a computer.\n\n"
    else
      print "\nOk, you chose to play another person.\n\n"
    end
  end

  def self.display_who_goes_1st(playing_computer)
    if playing_computer
      print "You will go first.\n\n"
    else
      print "You are Player x, and you will go first.\n\n"
    end
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

  def self.prompt_player_for_move(player_token, playing_computer)
    if playing_computer
      print "Please enter your move: "
    else
      print "Player #{player_token}, please enter your move: "
    end
  end

  def self.get_user_input
    $stdin.gets.chomp.to_sym
  end

  def self.display_game_over_msg(player_won, playing_computer, player_token)
    if !player_won
      display_draw_message
    else
      if !playing_computer
        display_winning_message(player_token)
      else
        display_message_vs_computer(player_token)
      end
    end
  end

  # ----- private -----

  def self.display_draw_message
    print "Game over. Resulted in a draw.\n"
  end

  def self.display_winning_message(player_token)
    print "Game over. Player #{player_token} won!\n"
  end

  def self.display_message_vs_computer(player_token)
    if player_token == "x"
      print "Game over. You won!\n"
    else
      print "Game over. You lost :(\n"
    end
  end

  private_class_method :display_draw_message, :display_winning_message,
    :display_message_vs_computer

end
