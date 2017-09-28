require 'board'
require 'score_tracker'
require 'controller'

xdescribe 'play_game' do
  it 'prints correct output when PX wins from moving to [t,c,b] (HvH)' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("h\n", "2\n", "3\n", "5\n",
                                               "6\n", "8\n")
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/px_wins_at_t_c_b.txt')

    expect{c.play_game}.to output(expected_output).to_stdout
  end
  
  it 'prints correct output when both players draw (HvH)' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("h\n", "2\n", "3\n", "5\n",
                                               "8\n", "6\n", "4\n", "1\n",
                                               "9\n", "7\n")
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/results_in_draw.txt')

    expect{c.play_game}.to output(expected_output).to_stdout
  end

  it 'prints correct output when human wins against computer (HvC)' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("c\n", "2\n", "5\n", "8\n")
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/human_wins.txt')

    expect{c.play_game}.to output(expected_output).to_stdout
  end
  
  it 'prints correct output when Px wins on last move (HvH)' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("h\n", "2\n", "3\n", "5\n",
                                               "8\n", "1\n", "4\n", "6\n",
                                               "7\n", "9\n")
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/px_wins_on_last_move.txt')

    expect{c.play_game}.to output(expected_output).to_stdout
  end

  it 'prints correct output when user enters invalid input for game mode' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("y\n", "h\n", "2\n", "3\n",
                                               "5\n", "6\n", "8\n")
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/invalid_input_for_game_mode.txt')

    expect{c.play_game}.to output(expected_output).to_stdout
  end

  it 'quits when user enters "q" for game mode' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("q\n")
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/quit_from_game_mode.txt')

    expect{c.play_game}.to output(expected_output).to_stdout
  end

  it 'quits when user enters "q" when playing a round' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("h\n", "2\n", "q\n")
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/quit_from_play_round.txt')

    expect{c.play_game}.to output(expected_output).to_stdout
  end
end


xdescribe 'play_round' do
  it 'displays correct output for Player X (PX) moving to 1 (HvH)' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("1\n")
    expected_output = "Player X, please enter your move (or \"q\" to quit): " +
                      " X | 2 | 3 \n" +
                      "---+---+---\n" +
                      " 4 | 5 | 6 \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    expect{c.play_round("X", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output for PX moving to 2 (HvC)' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("2\n")
    expected_output = "Please enter your move (or \"q\" to quit): " +
                      " 1 | X | 3 \n" +
                      "---+---+---\n" +
                      " 4 | 5 | 6 \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    expect{c.play_round("X", true)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if PX makes an invalid move to "z"' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("z\n", "5\n")
    expected_output = "Player X, please enter your move (or \"q\" to quit): " + 
                      "\n" +
                      "<!> Error: Move \"z\" is invalid.\n" +
                      "Please enter a move from 1-9: " +
                      " 1 | 2 | 3 \n" +
                      "---+---+---\n" +
                      " 4 | X | 6 \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    expect{c.play_round("X", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if Player O (PO) makes an invalid move to "y"' do
    c = Controller.new
    allow($stdin).to receive(:gets).and_return("y\n", "6\n")
    expected_output = "Player O, please enter your move (or \"q\" to quit): " + 
                      "\n" +
                      "<!> Error: Move \"y\" is invalid.\n" +
                      "Please enter a move from 1-9: " +
                      " 1 | 2 | 3 \n" +
                      "---+---+---\n" +
                      " 4 | 5 | O \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    expect{c.play_round("O", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if PX moves to 8 (which has been taken)' do
    b = Board.new(3)
    b.move(8, "X")
    b.move(9, "O")
    c = Controller.new(b)
    allow($stdin).to receive(:gets).and_return("8\n", "5\n")
    expected_output = "Player X, please enter your move (or \"q\" to quit): " +
                      "\n" +
                      "<!> Error: Move 8 has already been taken.\n" +
                      "Please enter a new move: " +
                      " 1 | 2 | 3 \n" +
                      "---+---+---\n" +
                      " 4 | X | 6 \n" +
                      "---+---+---\n" +
                      " 7 | X | O \n" +
                      "\n"

    expect{c.play_round("X", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if PO moves to 2 (which has been taken)' do
    b = Board.new(3)
    b.move(2, "X")
    c = Controller.new(b)
    allow($stdin).to receive(:gets).and_return("2\n", "5\n")
    expected_output = "Player O, please enter your move (or \"q\" to quit): " +
                      "\n" +
                      "<!> Error: Move 2 has already been taken.\n" +
                      "Please enter a new move: " +
                      " 1 | X | 3 \n" +
                      "---+---+---\n" +
                      " 4 | O | 6 \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    expect{c.play_round("O", false)}.to output(expected_output).to_stdout
  end

  it 'prints output and returns "q" if PX chose "q"' do
    b = Board.new(3)
    c = Controller.new(b)
    allow($stdin).to receive(:gets).and_return("q\n")
    expected_output = "Player X, please enter your move (or \"q\" to quit): "

    expect{c.play_round("X", false)}.to output(expected_output).to_stdout
    expect(c.play_round("X", false)).to eq("q")
  end
end
