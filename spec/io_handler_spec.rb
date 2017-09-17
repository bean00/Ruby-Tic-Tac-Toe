require 'io_handler'
require 'board'

describe 'display_intro_and_instructions' do
  it 'displays the introduction and instructions to select game mode' do
    handler = IOHandler.new
    exp_out = "Hello! This is a Tic Tac Toe program.\n" +
              "\n" +
              "*Enter \"q\" at any time to quit the program.\n" +
              "\n" +
              "Please enter one of the following:\n" +
              "- \"h\" to play against another person\n" +
              "- \"c\" to play against a computer\n" +
              "(Or \"q\" to quit)\n" +
              "\n"

    expect{handler.display_intro_and_instructions}.to output(exp_out).to_stdout
  end
end


describe 'display_game_instructions' do
  it 'displays the game instructions for Human vs. Computer (HvC) mode' do
    handler = IOHandler.new
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

    expect{handler.display_game_instructions(true)}.to output(exp_out).to_stdout
  end

  it 'displays the game instructions for Human vs. Human (HvH) mode' do
    handler = IOHandler.new
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

    expect{handler.display_game_instructions(false)}.to output(exp_out).to_stdout
  end
end


describe 'get_valid_game_mode' do
  it 'prints output and returns value for a valid mode "h"' do
    handler = IOHandler.new
    allow($stdin).to receive(:gets).and_return("h\n")
    expected_output = "> "

    expect{handler.get_valid_game_mode}.to output(expected_output).to_stdout
    expect(handler.get_valid_game_mode).to eq("h")
  end
  
  it 'prints output and returns value for a valid mode "c"' do
    handler = IOHandler.new
    allow($stdin).to receive(:gets).and_return("c\n")
    expected_output = "> "

    expect{handler.get_valid_game_mode}.to output(expected_output).to_stdout
    expect(handler.get_valid_game_mode).to eq("c")
  end

  it 'prints output and returns value for an invalid mode "y"' do
    handler = IOHandler.new
    allow($stdin).to receive(:gets).and_return("y\n", "h\n")
    expected_output = "> \n" +
                      "<!> Error: Invalid input for game mode.\n" +
                      "Please enter a valid choice (\"h\", \"c\"): " 

    expect{handler.get_valid_game_mode}.to output(expected_output).to_stdout
    expect(handler.get_valid_game_mode).to eq("h")
  end

  it 'prints output and returns value for a valid mode "q"' do
    handler = IOHandler.new
    allow($stdin).to receive(:gets).and_return("q\n")
    expected_output = "> "

    expect{handler.get_valid_game_mode}.to output(expected_output).to_stdout
    expect(handler.get_valid_game_mode).to eq("q")
  end
end 


describe 'get_valid_move' do
  it 'returns the correct value for a valid move to "8"' do
    b = Board.new(3)
    handler = IOHandler.new
    allow($stdin).to receive(:gets).and_return("8\n")

    move = handler.get_valid_move(b.to_string_array)

    expect(move).to eq("8")
  end

  it 'prints output and returns value for an invalid move to "z"' do
    b = Board.new(3)
    b_arr = b.to_string_array
    handler = IOHandler.new
    allow($stdin).to receive(:gets).and_return("z\n", "3\n")
    expected_output = "\n<!> Error: Move \"z\" is invalid.\n" +
                      "Please enter a move from 1-9: "

    expect{handler.get_valid_move(b_arr)}.to output(expected_output).to_stdout
    expect(handler.get_valid_move(b_arr)).to eq("3")
  end

  it 'prints output and returns value for a move already made to "4"' do
    b = Board.new(3)
    b.move(4, "X")
    b_arr = b.to_string_array
    handler = IOHandler.new
    allow($stdin).to receive(:gets).and_return("4\n", "1\n")
    expected_output = "\n<!> Error: Move 4 has already been taken.\n" +
                      "Please enter a new move: "

    expect{handler.get_valid_move(b_arr)}.to output(expected_output).to_stdout
    expect(handler.get_valid_move(b_arr)).to eq("1")
  end

  it 'returns "q" when the user enters "q"' do
    b = Board.new(3)
    handler = IOHandler.new
    allow($stdin).to receive(:gets).and_return("q\n")

    move = handler.get_valid_move(b.to_string_array)

    expect(move).to eq("q")
  end
end


describe 'prompt_player_for_move' do
  it 'displays the correct prompt for the player that went 1st (HvH)' do
    handler = IOHandler.new
    prompt = "Player X, please enter your move (or \"q\" to quit): "

    expect{handler.prompt_player_for_move("X", false)}.to output(prompt).to_stdout
  end

  it 'displays the correct prompt for the player that went 2nd (HvH)' do
    handler = IOHandler.new
    prompt = "Player O, please enter your move (or \"q\" to quit): "

    expect{handler.prompt_player_for_move("O", false)}.to output(prompt).to_stdout
  end

  it 'displays the correct prompt for the human player (HvC)' do
    handler = IOHandler.new
    prompt = "Please enter your move (or \"q\" to quit): "

    expect{handler.prompt_player_for_move(1, true)}.to output(prompt).to_stdout
  end
end


describe 'display_computer_moved' do
  it 'displays a message showing the computer moved' do
    handler = IOHandler.new
    expected_output = "The computer moved.\n"

    expect{handler.display_computer_moved}.to output(expected_output).to_stdout
  end
end


describe 'display_game_over_msg' do
  it 'displays the correct message if Player X won (HvH)' do
    handler = IOHandler.new
    msg = "Game over. Player X won!\n"

    expect {
      handler.display_game_over_msg(true, false, false, "X")
    }.to output(msg).to_stdout
  end

  it 'displays the correct message if the game resulted in a draw (HvH)' do
    handler = IOHandler.new
    msg = "Game over. Resulted in a draw.\n"

    expect {
      handler.display_game_over_msg(false, false, false, "X")
    }.to output(msg).to_stdout
  end

  it 'displays the correct message if the human won (HvC)' do
    handler = IOHandler.new
    msg = "Game over. You won!\n"

    expect {
      handler.display_game_over_msg(true, false, true, "X")
    }.to output(msg).to_stdout
  end

  it 'displays the correct message if the computer won (HvC)' do
    handler = IOHandler.new
    msg = "Game over. You lost :(\n"

    expect {
      handler.display_game_over_msg(true, false, true, "O")
    }.to output(msg).to_stdout
  end

  it 'displays the correct message if the player quit' do
    handler = IOHandler.new
    msg = "\n" +
          "Quit program successfully.\n"

    expect {
      handler.display_game_over_msg(true, true, true, "O")
    }.to output(msg).to_stdout
  end
end


