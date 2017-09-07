require 'io_handler'

describe 'display_introduction' do
  it 'displays the introduction to the Tic Tac Toe game' do
    introduction = "Hello! This is a Tic Tac Toe program.\n" +
                   "\n"

    expect{IOHandler.display_introduction}.to output(introduction).to_stdout
  end
end


describe 'display_game_mode_instructions' do
  it 'displays the instructions for selecting the game mode' do
    instructions = "Please enter one of the following:\n" +
                   "- \"h\" to play against another person\n" +
                   "- \"c\" to play against a computer\n" +
                   "\n"

    expect {
      IOHandler.display_game_mode_instructions
    }.to output(instructions).to_stdout
  end
end


describe 'get_user_input_for_game_mode' do
  it 'displays ">" and gets user input' do
    allow($stdin).to receive(:gets).and_return("c\n")

    expect{IOHandler.get_user_input_for_game_mode}.to output("> ").to_stdout
  end
end


describe 'dislpay_game_mode' do
  it 'displays computer message for Human vs. Computer mode' do
    comp_msg = "\nOk, you chose to play a computer.\n\n"

    expect{IOHandler.display_game_mode(true)}.to output(comp_msg).to_stdout
  end

  it 'displays human message for Human vs. Human mode' do
    human_msg = "\nOk, you chose to play another person.\n\n"

    expect{IOHandler.display_game_mode(false)}.to output(human_msg).to_stdout
  end
end


describe 'display_who_goes_1st' do
  it 'displays computer message for Human vs. Computer mode' do
    comp_msg = "You will go first.\n\n"

    expect{IOHandler.display_who_goes_1st(true)}.to output(comp_msg).to_stdout
  end

  it 'displays human message for Human vs. Human mode' do
    hum_msg = "You are Player x, and you will go first.\n\n"

    expect{IOHandler.display_who_goes_1st(false)}.to output(hum_msg).to_stdout
  end
end


describe 'display_instructions' do
  it 'displays the instructions for the Tic Tac Toe game' do
    instructions = "To enter a move, type:\n" +
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

    expect{IOHandler.display_instructions}.to output(instructions).to_stdout
  end
end


describe 'prompt_player_for_move' do
  it 'displays the correct prompt for the player that went 1st (HvH)' do
    prompt = "Player x, please enter your move: "

    expect{IOHandler.prompt_player_for_move("x", false)}.to output(prompt).to_stdout
  end

  it 'displays the correct prompt for the player that went 2nd (HvH)' do
    prompt = "Player o, please enter your move: "

    expect{IOHandler.prompt_player_for_move("o", false)}.to output(prompt).to_stdout
  end

  it 'displays the correct prompt for the human player (HvC)' do
    prompt = "Please enter your move: "

    expect{IOHandler.prompt_player_for_move(1, true)}.to output(prompt).to_stdout
  end
end


describe 'get_user_input' do
  it 'gets user input' do
    allow($stdin).to receive(:gets).and_return("tl\n")
    input = IOHandler.get_user_input

    expect(input).to eq("tl")
  end
end


describe 'display_game_over_msg' do
  it 'displays the correct message if Player x won (HvH)' do
    msg = "Game over. Player x won!\n"

    expect {
      IOHandler.display_game_over_msg(true, false, "x")
    }.to output(msg).to_stdout
  end

  it 'displays the correct message if the game resulted in a draw (HvH)' do
    msg = "Game over. Resulted in a draw.\n"

    expect {
      IOHandler.display_game_over_msg(false, false, "x")
    }.to output(msg).to_stdout
  end

  it 'displays the correct message if the human won (HvC)' do
    msg = "Game over. You won!\n"

    expect {
      IOHandler.display_game_over_msg(true, true, "x")
    }.to output(msg).to_stdout
  end

  it 'displays the correct message if the computer won (HvC)' do
    msg = "Game over. You lost :(\n"

    expect {
      IOHandler.display_game_over_msg(true, true, "o")
    }.to output(msg).to_stdout
  end
end


