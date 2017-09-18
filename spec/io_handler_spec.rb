require 'io_handler'
require 'board'

describe 'display_intro_and_instructions' do
  context 'when the user starts the game' do
    it 'displays the introduction and instructions' do
      h = IOHandler.new
      exp_out = "Hello! This is a Tic Tac Toe program.\n" +
                "\n" +
                "*Enter \"q\" at any time to quit the program.\n" +
                "\n" +
                "Please enter one of the following:\n" +
                "- \"h\" to play against another person\n" +
                "- \"c\" to play against a computer\n" +
                "(Or \"q\" to quit)\n" +
                "\n"

      expect{h.display_intro_and_instructions}.to output(exp_out).to_stdout
    end
  end
end


describe 'display_game_instructions' do
  let(:h) { IOHandler.new }

  context 'with Human vs. Computer (HvC) mode' do
    it 'displays the game instructions' do
      exp_out = "\nOk, you chose to play a computer.\n" +
                "\n" +
                "You will go first.\n" +
                "\n" +
                "To enter a move, type a number from 1-9.\n" +
                "It will be added to the board based on\n" +
                "the following positions:\n" +
                "\n" +
                " 1 | 2 | 3 \n" +
                "---+---+---\n" +
                " 4 | 5 | 6 \n" +
                "---+---+---\n" +
                " 7 | 8 | 9 \n" +
                "\n"

      expect{h.display_game_instructions(true)}.to output(exp_out).to_stdout
    end
  end

  context 'with Human vs. Human (HvH) mode' do
    it 'displays the game instructions' do
      exp_out = "\nOk, you chose to play another person.\n" +
                "\n" +
                "You are Player X, and you will go first.\n" +
                "\n" +
                "To enter a move, type a number from 1-9.\n" +
                "It will be added to the board based on\n" +
                "the following positions:\n" +
                "\n" +
                " 1 | 2 | 3 \n" +
                "---+---+---\n" +
                " 4 | 5 | 6 \n" +
                "---+---+---\n" +
                " 7 | 8 | 9 \n" +
                "\n"

      expect{h.display_game_instructions(false)}.to output(exp_out).to_stdout
    end
  end
end


describe 'get_valid_game_mode' do
  let(:h) { IOHandler.new }

  context 'with a valid mode "h"' do
    it 'displays output and returns a value' do
      allow($stdin).to receive(:gets).and_return("h\n")
      expected_output = "> "

      expect{h.get_valid_game_mode}.to output(expected_output).to_stdout
      expect(h.get_valid_game_mode).to eq("h")
    end
  end
    
  context 'with a valid mode "c"' do
    it 'displays output and returns a value' do
      allow($stdin).to receive(:gets).and_return("c\n")
      expected_output = "> "

      expect{h.get_valid_game_mode}.to output(expected_output).to_stdout
      expect(h.get_valid_game_mode).to eq("c")
    end
  end

  context 'with an invalid mode "y"' do
    it 'displays output and returns a value' do
      allow($stdin).to receive(:gets).and_return("y\n", "h\n")
      expected_output = "> \n" +
                        "<!> Error: Invalid input for game mode.\n" +
                        "Please enter a valid choice (\"h\", \"c\"): " 

      expect{h.get_valid_game_mode}.to output(expected_output).to_stdout
      expect(h.get_valid_game_mode).to eq("h")
    end
  end

  context 'with a valid mode "q"' do
    it 'displays output and returns a value' do
      allow($stdin).to receive(:gets).and_return("q\n")
      expected_output = "> "

      expect{h.get_valid_game_mode}.to output(expected_output).to_stdout
      expect(h.get_valid_game_mode).to eq("q")
    end
  end
end 


describe 'get_valid_move' do
  let(:b) { Board.new(3) }
  let(:h) { IOHandler.new }

  context 'with a valid move to "8"' do
    it 'returns the correct value' do
      allow($stdin).to receive(:gets).and_return("8\n")

      move = h.get_valid_move(b.to_string_array)

      expect(move).to eq("8")
    end
  end

  context 'with an invalid move to "z"' do
    it 'displays output and returns a value' do
      allow($stdin).to receive(:gets).and_return("z\n", "3\n")
      board_array = b.to_string_array
      expected_output = "\n<!> Error: Move \"z\" is invalid.\n" +
                        "Please enter a move from 1-9: "

      expect{h.get_valid_move(board_array)}.to output(expected_output).to_stdout
      expect(h.get_valid_move(board_array)).to eq("3")
    end
  end

  context 'with a move already made to "4"' do
    it 'displays output and returns a value' do
      b.move(4, "X")
      allow($stdin).to receive(:gets).and_return("4\n", "1\n")
      board_array = b.to_string_array
      expected_output = "\n<!> Error: Move 4 has already been taken.\n" +
                        "Please enter a new move: "

      expect{h.get_valid_move(board_array)}.to output(expected_output).to_stdout
      expect(h.get_valid_move(board_array)).to eq("1")
    end
  end

  context 'when the user enters "q"' do
    it 'returns "q"' do
      allow($stdin).to receive(:gets).and_return("q\n")

      move = h.get_valid_move(b.to_string_array)

      expect(move).to eq("q")
    end
  end
end


describe 'prompt_player_for_move' do
  let(:h) { IOHandler.new }

  context 'with a player that went 1st (HvH)' do
    it 'displays the correct prompt' do
      prompt = "Player X, please enter your move (or \"q\" to quit): "

      expect{h.prompt_player_for_move("X", false)}.to output(prompt).to_stdout
    end
  end

  context 'with a player that went 2nd (HvH)' do
    it 'displays the correct prompt' do
      prompt = "Player O, please enter your move (or \"q\" to quit): "

      expect{h.prompt_player_for_move("O", false)}.to output(prompt).to_stdout
    end
  end

  context 'with a human player (HvC)' do
    it 'displays the correct prompt' do
      prompt = "Please enter your move (or \"q\" to quit): "

      expect{h.prompt_player_for_move(1, true)}.to output(prompt).to_stdout
    end
  end
end


describe 'display_computer_moved' do
  context 'when the computer moves' do
    it 'displays a message' do
      h = IOHandler.new
      expected_output = "The computer moved.\n"

      expect{h.display_computer_moved}.to output(expected_output).to_stdout
    end
  end
end


describe 'display_game_over_msg' do
  let(:h) { IOHandler.new }

  context 'when Player X wins (HvH)' do
    it 'displays the correct message' do
      msg = "Game over. Player X won!\n"

      expect{h.display_game_over_msg(true, false, false, "X")}.to output(msg).to_stdout
    end
  end

  context 'when the game results in a draw (HvH)' do
    it 'displays the correct message' do
      msg = "Game over. Resulted in a draw.\n"

      expect{h.display_game_over_msg(false, false, false, "X")}.to output(msg).to_stdout
    end
  end

  context 'when the human wins (HvC)' do
    it 'displays the correct message' do
      msg = "Game over. You won!\n"

      expect{h.display_game_over_msg(true, false, true, "X")}.to output(msg).to_stdout
    end
  end

  context 'when the computer wins (HvC)' do
    it 'displays the correct message' do
      msg = "Game over. You lost :(\n"

      expect{h.display_game_over_msg(true, false, true, "O")}.to output(msg).to_stdout
    end
  end

  context 'when the player quits' do
    it 'displays the correct message' do
      msg = "\n" +
            "Quit program successfully.\n"

      expect{h.display_game_over_msg(true, true, true, "O")}.to output(msg).to_stdout
    end
  end
end
