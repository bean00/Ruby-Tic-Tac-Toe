require 'board'
require 'score_tracker'
require 'controller'

describe 'play_game' do
  it 'prints the correct output when P1 (x) wins from moving to [t,c,b]' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/p1_wins_at_t_c_b.txt')

    allow($stdin).to receive(:gets).and_return("t\n", "tr\n", "c\n", "r\n",
                                               "b\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end

  it 'prints the correct output when both players draw' do
    c = Controller.new
    expected_output = File.read(File.dirname(__FILE__) +
                                '/expected-output/results_in_draw.txt')

    allow($stdin).to receive(:gets).and_return("t\n", "tr\n", "c\n",
                                               "b\n", "r\n",  "l\n",
                                               "tl\n", "br\n", "bl\n")

    expect{c.play_game}.to output(expected_output).to_stdout
  end
end


describe 'play_round' do
  it 'displays the correct output for Player 1 (x) moving to the top left' do
    c = Controller.new
    expected_output = "Player 1, please enter your move: " +
                      " x |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "---+---+---\n" +
                      "   |   |   \n" +
                      "\n"

    allow($stdin).to receive(:gets).and_return("tl\n")

    expect{c.play_round(1)}.to output(expected_output).to_stdout
  end
end


describe 'prompt_player_for_move' do
  it 'displays the correct prompt for Player 1' do
    c = Controller.new
    prompt = "Player 1, please enter your move: "

    expect{c.prompt_player_for_move(1)}.to output(prompt).to_stdout
  end
end


describe 'get_move' do
  it 'gets user input' do
    c = Controller.new

    allow($stdin).to receive(:gets).and_return("tl\n")
    input = c.get_move

    expect(input).to eq("tl")
  end
end


