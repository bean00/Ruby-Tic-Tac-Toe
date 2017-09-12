require 'board'
require 'score_tracker'
require 'controller'

describe 'play_game' do
  it 'prints correct output when PX wins from moving to [t,c,b] (HvH)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/px_wins_at_t_c_b.txt')

    allow($stdin).to receive(:gets).and_return("h\n", "2\n", "3\n", "5\n",
                                               "6\n", "8\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end
  
  it 'prints correct output when both players draw (HvH)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/results_in_draw.txt')

    allow($stdin).to receive(:gets).and_return("h\n", "2\n", "3\n", "5\n",
                                               "8\n", "6\n", "4\n", "1\n",
                                               "9\n", "7\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end

  it 'prints correct output when human wins against computer (HvC)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/human_wins.txt')

    allow($stdin).to receive(:gets).and_return("c\n", "2\n", "5\n", "8\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end
  
  it 'prints correct output when Px wins on last move (HvH)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/px_wins_on_last_move.txt')

    allow($stdin).to receive(:gets).and_return("h\n", "2\n", "3\n", "5\n",
                                               "8\n", "1\n", "4\n", "6\n",
                                               "7\n", "9\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end

  it 'prints correct output when user enters invalid input for game mode' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/invalid_input_for_game_mode.txt')

    allow($stdin).to receive(:gets).and_return("y\n", "h\n", "2\n", "3\n",
                                               "5\n", "6\n", "8\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end
end


describe 'play_round' do
  it 'displays correct output for Player X (PX) moving to 1 (HvH)' do
    c = Controller.new
    expected_output = "Player X, please enter your move: " +
                      " X | 2 | 3 \n" +
                      "---+---+---\n" +
                      " 4 | 5 | 6 \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("1\n")

    expect{c.play_round("X", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output for PX moving to 2 (HvC)' do
    c = Controller.new
    expected_output = "Please enter your move: " +
                      " 1 | X | 3 \n" +
                      "---+---+---\n" +
                      " 4 | 5 | 6 \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("2\n")

    expect{c.play_round("X", true)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if PX makes an invalid move to "z"' do
    c = Controller.new
    expected_output = "Player X, please enter your move: " + 
                      "\n" +
                      "<!> Error: Move \"z\" is invalid.\n" +
                      "Please enter a move from 1-9: " +
                      " 1 | 2 | 3 \n" +
                      "---+---+---\n" +
                      " 4 | X | 6 \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("z\n", "5\n")

    expect{c.play_round("X", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if Player O (PO) makes an invalid move to "y"' do
    c = Controller.new
    expected_output = "Player O, please enter your move: " + 
                      "\n" +
                      "<!> Error: Move \"y\" is invalid.\n" +
                      "Please enter a move from 1-9: " +
                      " 1 | 2 | 3 \n" +
                      "---+---+---\n" +
                      " 4 | 5 | O \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("y\n", "6\n")

    expect{c.play_round("O", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if PX moves to 8 (which has been taken)' do
    b = Board.new(3)
    b.move(8, "X")
    b.move(9, "O")
    c = Controller.new(b)
    expected_output = "Player X, please enter your move: " +
                      "\n" +
                      "<!> Error: Move 8 has already been taken.\n" +
                      "Please enter a new move: " +
                      " 1 | 2 | 3 \n" +
                      "---+---+---\n" +
                      " 4 | X | 6 \n" +
                      "---+---+---\n" +
                      " 7 | X | O \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("8\n", "5\n")

    expect{c.play_round("X", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if PO moves to 2 (which has been taken)' do
    b = Board.new(3)
    b.move(2, "X")
    c = Controller.new(b)
    expected_output = "Player O, please enter your move: " +
                      "\n" +
                      "<!> Error: Move 2 has already been taken.\n" +
                      "Please enter a new move: " +
                      " 1 | X | 3 \n" +
                      "---+---+---\n" +
                      " 4 | O | 6 \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("2\n", "5\n")

    expect{c.play_round("O", false)}.to output(expected_output).to_stdout
  end
end
