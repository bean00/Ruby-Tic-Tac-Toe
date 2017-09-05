require 'board'
require 'score_tracker'
require 'controller'

describe 'play_game' do
  it 'prints the correct output when P1 wins from moving to [t,c,b] (HvH)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/p1_wins_at_t_c_b.txt')

    allow($stdin).to receive(:gets).and_return("h\n", "t\n", "tr\n", "c\n",
                                               "r\n", "b\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end

  it 'prints the correct output when both players draw (HvH)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/results_in_draw.txt')

    allow($stdin).to receive(:gets).and_return("h\n", "t\n", "tr\n", "c\n",
                                               "b\n", "r\n",  "l\n", "tl\n",
                                               "br\n", "bl\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end

  it 'prints the correct output when human wins against computer (HvC)' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/human_wins_for_test.txt')

    allow($stdin).to receive(:gets).and_return("c\n", "t\n", "c\n", "b\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end
end


describe 'play_round' do
  it 'displays the correct output for P1 moving to the top left (HvH)' do
    c = Controller.new
    expected_output = "Player 1, please enter your move: " +
                      " x |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("tl\n")

    expect{c.play_round(1, false)}.to output(expected_output).to_stdout
  end

  it 'displays the correct output for P1 moving to the top (HvC)' do
    c = Controller.new
    expected_output = "Please enter your move: " +
                      "   | x |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("t\n")

    expect{c.play_round(1, true)}.to output(expected_output).to_stdout
  end

  it 'displays the correct output if P1 makes an invalid move to "x"' do
    c = Controller.new
    expected_output = "Player 1, please enter your move: " + 
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

    expect{c.play_round(1, false)}.to output(expected_output).to_stdout
  end

  it 'displays the correct output if P2 makes an invalid move to "y"' do
    c = Controller.new
    expected_output = "Player 2, please enter your move: " + 
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

    expect{c.play_round(2, false)}.to output(expected_output).to_stdout
  end

  it 'displays the correct output if P1 moves to "b" (which has been taken)' do
    b = Board.new
    b.move("b", "x")
    b.move("br", "o")
    c = Controller.new(b)
    expected_output = "Player 1, please enter your move: " +
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

    expect{c.play_round(1, false)}.to output(expected_output).to_stdout
  end

  it 'displays the correct output if P2 moves to "t" (which has been taken)' do
    b = Board.new
    b.move("t", "x")
    c = Controller.new(b)
    expected_output = "Player 2, please enter your move: " +
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

    expect{c.play_round(2, false)}.to output(expected_output).to_stdout
  end
end
