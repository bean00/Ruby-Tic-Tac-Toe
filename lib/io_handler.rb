require_relative 'input_validator'

class IOHandler

  def display_intro_and_instructions
    display_introduction

    display_game_mode_instructions
  end

  def display_game_instructions(playing_computer)
    display_game_mode(playing_computer)

    display_who_goes_1st(playing_computer)

    display_move_instructions
  end

  def get_valid_game_mode
    print "> "

    mode = get_user_input

    while is_mode_invalid?(mode)
      display_invalid_game_mode_error
      mode = get_user_input
    end

    mode
  end

  def get_valid_move(board_string_array)
    move = get_user_input
    iv = InputValidator.new(board_string_array)

    while (!iv.is_move_valid?(move) || !iv.is_position_empty?(move)) &&
           (move != "q")
      if !iv.is_move_valid?(move)
        display_invalid_move_error(move)
        move = get_user_input
      elsif !iv.is_position_empty?(move)
        display_move_taken_error(move)
        move = get_user_input
      end
    end

    move
  end

  def display_move_output(token, playing_computer)
    if !playing_computer
      print "Player #{token}, please enter your move (or \"q\" to quit): "
    elsif playing_computer
      if token == "X"
        print "Please enter your move (or \"q\" to quit): "
      elsif token == "O"
        print "The computer moved.\n"
      end
    end
  end

  def display_game_over_msg(a_player_has_won, has_quit, playing_comp, token)
    if has_quit
      display_quit_message
    elsif !a_player_has_won
      display_draw_message
    elsif a_player_has_won
      if !playing_comp
        display_winning_message(token)
      else
        display_message_vs_computer(token)
      end
    end
  end

  private

  def display_introduction
    print "Hello! This is a Tic Tac Toe program.\n" +
          "\n"
  end

  def display_game_mode_instructions
    print "*Enter \"q\" at any time to quit the program.\n" +
          "\n" +
          "Please enter one of the following:\n" +
          "- \"h\" to play against another person\n" +
          "- \"c\" to play against a computer\n" +
          "(Or \"q\" to quit)\n" +
          "\n"
  end


  def display_game_mode(playing_computer)
    if playing_computer
      print "\nOk, you chose to play a computer.\n\n"
    else
      print "\nOk, you chose to play another person.\n\n"
    end
  end

  def display_who_goes_1st(playing_computer)
    if playing_computer
      print "You will go first.\n\n"
    else
      print "You are Player X, and you will go first.\n\n"
    end
  end

  def display_move_instructions
    print "To enter a move, type a number from 1-9.\n" +
          "It will be added to the board based on\n" +
          "the following positions:\n" +
          "\n" +
          " 1 | 2 | 3 \n" +
          "---+---+---\n" +
          " 4 | 5 | 6 \n" +
          "---+---+---\n" +
          " 7 | 8 | 9 \n" +
          "\n"
  end


  def get_user_input
    $stdin.gets.chomp.to_str
  end

  def is_mode_invalid?(mode)
    (mode != "h") && (mode != "c") && (mode != "q")
  end

  def display_invalid_game_mode_error
    print "\n<!> Error: Invalid input for game mode.\n" +
          "Please enter a valid choice (\"h\", \"c\"): "
  end


  def display_invalid_move_error(move)
    print "\n<!> Error: Move \"#{move}\" is invalid.\n" +
          "Please enter a move from 1-9: "
  end

  def display_move_taken_error(move)
    print "\n<!> Error: Move #{move} has already been taken.\n" +
          "Please enter a new move: "
  end


  def display_quit_message
    print "\n" +
          "Quit program successfully.\n"
  end

  def display_draw_message
    print "Game over. Resulted in a draw.\n"
  end

  def display_winning_message(player_token)
    print "Game over. Player #{player_token} won!\n"
  end

  def display_message_vs_computer(player_token)
    if player_token == "X"
      print "Game over. You won!\n"
    else
      print "Game over. You lost :(\n"
    end
  end

end
