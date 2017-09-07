require 'board'
require 'score_tracker'
require 'controller'

describe 'play_game' do
  it 'prints correct output when Px wins from moving to [t,c,b] (HvH)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/px_wins_at_t_c_b.txt')

    allow($stdin).to receive(:gets).and_return("h\n", "t\n", "tr\n", "c\n",
                                               "r\n", "b\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end
  
  it 'prints correct output when both players draw (HvH)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/results_in_draw.txt')

    allow($stdin).to receive(:gets).and_return("h\n", "t\n", "tr\n", "c\n",
                                               "b\n", "r\n",  "l\n", "tl\n",
                                               "br\n", "bl\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end

  it 'prints correct output when human wins against computer (HvC)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/human_wins_for_test.txt')

    allow($stdin).to receive(:gets).and_return("c\n", "t\n", "c\n", "b\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end
  
  it 'prints correct output when Px wins on last move (HvH)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/px_wins_on_last_move.txt')

    allow($stdin).to receive(:gets).and_return("h\n", "t\n", "tr\n", "c\n",
                                               "b\n", "tl\n", "l\n", "r\n",
                                               "bl\n", "br\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end
end


describe 'play_round' do
  it 'displays correct output for Player x (Px) moving to the top left (HvH)' do
    c = Controller.new
    expected_output = "Player x, please enter your move: " +
                      " x |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("tl\n")

    expect{c.play_round("x", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output for Px moving to the top (HvC)' do
    c = Controller.new
    expected_output = "Please enter your move: " +
                      "   | x |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("t\n")

    expect{c.play_round("x", true)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if Px makes an invalid move to "x"' do
    c = Controller.new
    expected_output = "Player x, please enter your move: " + 
                      "\n" +
                      "<!> Error: Move \"x\" doesn't exist.\n" +
                      "Please enter a move that exists (ex: \"tl\", \"c\"): " +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   | x |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("x\n", "c\n")

    expect{c.play_round("x", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if Player o (Po) makes an invalid move to "y"' do
    c = Controller.new
    expected_output = "Player o, please enter your move: " + 
                      "\n" +
                      "<!> Error: Move \"y\" doesn't exist.\n" +
                      "Please enter a move that exists (ex: \"tl\", \"c\"): " +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   | o \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("y\n", "r\n")

    expect{c.play_round("o", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if Px moves to "b" (which has been taken)' do
    b = Board.new
    b.move("b", "x")
    b.move("br", "o")
    c = Controller.new(b)
    expected_output = "Player x, please enter your move: " +
                      "\n" +
                      "<!> Error: The position at \"b\" has already been taken.\n" +
                      "Please enter a new move: " +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   | x |   \n" +
                      "---+---+---\n" +
                      "   | x | o \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("b\n", "c\n")

    expect{c.play_round("x", false)}.to output(expected_output).to_stdout
  end

  it 'displays correct output if Po moves to "t" (which has been taken)' do
    b = Board.new
    b.move("t", "x")
    c = Controller.new(b)
    expected_output = "Player o, please enter your move: " +
                      "\n" +
                      "<!> Error: The position at \"t\" has already been taken.\n" +
                      "Please enter a new move: " +
                      "   | x |   \n" +
                      "---+---+---\n" +
                      "   | o |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("t\n", "c\n")

    expect{c.play_round("o", false)}.to output(expected_output).to_stdout
  end
end
