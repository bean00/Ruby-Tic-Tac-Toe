require 'io_handler'

describe 'display_introduction' do
  it 'displays the introduction to the Tic Tac Toe game' do
    introduction = "Hello! This is a Tic Tac Toe program.\n" +
                   "\n"

    expect{IOHandler.display_introduction}.to output(introduction).to_stdout
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
  it 'displays the correct prompt for Player 1' do
    prompt = "Player 1, please enter your move: "

    expect{IOHandler.prompt_player_for_move(1)}.to output(prompt).to_stdout
  end
end


describe 'get_move' do
  it 'gets user input' do
    allow($stdin).to receive(:gets).and_return("tl\n")
    input = IOHandler.get_move

    expect(input).to eq("tl")
  end
end


describe 'display_game_over_msg' do
  it 'displays the correct message if Player 1 won' do
    msg = "Game over. Player 1 won!\n"

    expect{IOHandler.display_game_over_msg(5, 1)}.to output(msg).to_stdout
  end

  it 'displays the correct message if the games resulted in a draw' do
    msg = "Game over. Resulted in a draw.\n"

    expect{IOHandler.display_game_over_msg(10, 2)}.to output(msg).to_stdout
  end
end


