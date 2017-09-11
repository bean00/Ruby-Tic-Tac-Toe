require 'board'
require 'score_tracker'
require 'controller'

describe 'play_game' do
  it 'prints correct output when Px wins from moving to [t,c,b] (HvH)' do
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
  it 'displays correct output for Player x (Px) moving to 1 (HvH)' do
    c = Controller.new
    expected_output = "Player x, please enter your move: " +
                      " x |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("1\n")

    expect{c.play_round("x", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output for Px moving to 2 (HvC)' do
    c = Controller.new
    expected_output = "Please enter your move: " +
                      "   | x |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("2\n")

    expect{c.play_round("x", true)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if Px makes an invalid move to "x"' do
    c = Controller.new
    expected_output = "Player x, please enter your move: " + 
                      "\n" +
                      "<!> Error: Move \"x\" is invalid.\n" +
                      "Please enter a move from 1-9: " +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   | x |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("x\n", "5\n")

    expect{c.play_round("x", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if Player o (Po) makes an invalid move to "y"' do
    c = Controller.new
    expected_output = "Player o, please enter your move: " + 
                      "\n" +
                      "<!> Error: Move \"y\" is invalid.\n" +
                      "Please enter a move from 1-9: " +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   | o \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("y\n", "6\n")

    expect{c.play_round("o", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if Px moves to 8 (which has been taken)' do
    b = Board.new
    b.move(8, "x")
    b.move(9, "o")
    c = Controller.new(b)
    expected_output = "Player x, please enter your move: " +
                      "\n" +
                      "<!> Error: Move 8 has already been taken.\n" +
                      "Please enter a new move: " +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   | x |   \n" +
                      "---+---+---\n" +
                      "   | x | o \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("8\n", "5\n")

    expect{c.play_round("x", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if Po moves to 2 (which has been taken)' do
    b = Board.new
    b.move(2, "x")
    c = Controller.new(b)
    expected_output = "Player o, please enter your move: " +
                      "\n" +
                      "<!> Error: Move 2 has already been taken.\n" +
                      "Please enter a new move: " +
                      "   | x |   \n" +
                      "---+---+---\n" +
                      "   | o |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("2\n", "5\n")

    expect{c.play_round("o", false)}.to output(expected_output).to_stdout
  end
end
