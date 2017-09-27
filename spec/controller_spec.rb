require 'board'
require 'score_tracker'
require 'controller'

describe 'play_game' do
  let(:b) { Board.new(3) }
  let(:c) { Controller.new(b) }

  context 'when Player X wins (HvH)' do
    it 'displays the correct output' do
      allow($stdin).to receive(:gets).and_return("h\n", "2\n", "3\n", "5\n",
                                                 "6\n", "8\n")
      expected_output = File.read(File.dirname(__FILE__) +
                                  '/expected-output/px_wins_at_t_c_b.txt')

      expect{c.play_game}.to output(expected_output).to_stdout
    end
  end
    
  context 'when both players draw (HvH)' do
    it 'displays the correct output' do
      allow($stdin).to receive(:gets).and_return("h\n", "2\n", "3\n", "5\n",
                                                 "8\n", "6\n", "4\n", "1\n",
                                                 "9\n", "7\n")
      expected_output = File.read(File.dirname(__FILE__) +
                                  '/expected-output/results_in_draw.txt')

      expect{c.play_game}.to output(expected_output).to_stdout
    end
  end

  xcontext 'when a human wins against a computer (HvC)' do
    it 'displays the correct output' do
      allow($stdin).to receive(:gets).and_return("c\n", "2\n", "5\n", "8\n")
      expected_output = File.read(File.dirname(__FILE__) +
                                  '/expected-output/human_wins.txt')

      expect{c.play_game}.to output(expected_output).to_stdout
    end
  end
    
  context 'when Player X wins on last move (HvH)' do
    it 'displays the correct output' do
      allow($stdin).to receive(:gets).and_return("h\n", "2\n", "3\n", "5\n",
                                                 "8\n", "1\n", "4\n", "6\n",
                                                 "7\n", "9\n")
      expected_output = File.read(File.dirname(__FILE__) +
                                  '/expected-output/px_wins_on_last_move.txt')

      expect{c.play_game}.to output(expected_output).to_stdout
    end
  end

  context 'when the user enters invalid input for the game mode' do
    it 'displays the correct output' do
      allow($stdin).to receive(:gets).and_return("y\n", "h\n", "2\n", "3\n",
                                                 "5\n", "6\n", "8\n")
      expected_output = File.read(File.dirname(__FILE__) +
                                  '/expected-output/invalid_input_for_game_mode.txt')

      expect{c.play_game}.to output(expected_output).to_stdout
    end
  end

  context 'when the user enters "q" for the game mode' do
    it 'quits successfully' do
      allow($stdin).to receive(:gets).and_return("q\n")
      expected_output = File.read(File.dirname(__FILE__) +
                                  '/expected-output/quit_from_game_mode.txt')

      expect{c.play_game}.to output(expected_output).to_stdout
    end
  end

  context 'when the user enters "q" when playing a round' do
    it 'quits successfully' do
      allow($stdin).to receive(:gets).and_return("h\n", "2\n", "q\n")
      expected_output = File.read(File.dirname(__FILE__) +
                                  '/expected-output/quit_from_play_round.txt')

      expect{c.play_game}.to output(expected_output).to_stdout
    end
  end
end


describe 'play_round' do
  let(:b) { Board.new(3) }
  
  context 'when Player X (PX) moves to 1 (HvH)' do
    it 'displays the correct output' do
      c = Controller.new(b)
      person = HumanPlayer.new(1, b)
      allow($stdin).to receive(:gets).and_return("1\n")
      expected_output = "Player X, please enter your move (or \"q\" to quit): " +
                        " X | 2 | 3 \n" +
                        "---+---+---\n" +
                        " 4 | 5 | 6 \n" +
                        "---+---+---\n" +
                        " 7 | 8 | 9 \n" +
                        "\n"

      expect{c.play_round(person, false)}.to output(expected_output).to_stdout
    end
  end

  context 'when PX moves to 2 (HvC)' do
    it 'displays the correct output' do
      c = Controller.new(b)
      person = HumanPlayer.new(1, b)
      allow($stdin).to receive(:gets).and_return("2\n")
      expected_output = "Please enter your move (or \"q\" to quit): " +
                        " 1 | X | 3 \n" +
                        "---+---+---\n" +
                        " 4 | 5 | 6 \n" +
                        "---+---+---\n" +
                        " 7 | 8 | 9 \n" +
                        "\n"

      expect{c.play_round(person, true)}.to output(expected_output).to_stdout
    end
  end

  context 'when PX makes an invalid move to "z"' do
    it 'displays the correct output' do
      c = Controller.new(b)
      person = HumanPlayer.new(1, b)
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

      expect{c.play_round(person, false)}.to output(expected_output).to_stdout
    end
  end

  context 'when Player O (PO) makes an invalid move to "y"' do
    it 'displays the correct output' do
      c = Controller.new(b)
      person = HumanPlayer.new(2, b)
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

      expect{c.play_round(person, false)}.to output(expected_output).to_stdout
    end
  end

  context 'when PX moves to 8 (which has been taken)' do
    it 'displays the correct output' do
      b.move(8, "X")
      b.move(9, "O")
      c = Controller.new(b)
      person = HumanPlayer.new(1, b)
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

      expect{c.play_round(person, false)}.to output(expected_output).to_stdout
    end
  end

  context 'when PO moves to 2 (which has been taken)' do
    it 'displays the correct output' do
      b.move(2, "X")
      c = Controller.new(b)
      person = HumanPlayer.new(2, b)
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

      expect{c.play_round(person, false)}.to output(expected_output).to_stdout
    end
  end

  context 'when PX enters "q"' do
    it 'displays output and returns "q"' do
      c = Controller.new(b)
      person = HumanPlayer.new(1, b)
      allow($stdin).to receive(:gets).and_return("q\n")
      expected_output = "Player X, please enter your move (or \"q\" to quit): "

      expect{c.play_round(person, false)}.to output(expected_output).to_stdout
      expect(c.play_round(person, false)).to eq("q")
    end
  end
end
