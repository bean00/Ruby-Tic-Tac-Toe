require 'board'
require 'view'

X_G = "\e[0;32;49mX\e[0m"
O_R = "\e[0;31;49mO\e[0m"

describe 'display_board' do
  xit 'prints a formatted board if all positions are "x"s' do
    b = Board.new(3)
    b.move(1, "X")
    b.move(2, "X")
    b.move(3, "X")
    b.move(4, "X")
    b.move(5, "X")
    b.move(6, "X")
    b.move(7, "X")
    b.move(8, "X")
    b.move(9, "X")
    v = View.new(b.to_string_array)
    formatted_board = " X | X | X \n" +
                      "---+---+---\n" +
                      " X | X | X \n" +
                      "---+---+---\n" +
                      " X | X | X \n" +
                      "\n"

    expect{v.display_board}.to output(formatted_board).to_stdout
  end

  it 'prints a formatted board if all positions are empty' do
    b = Board.new(3)
    v = View.new(b.to_string_array)
    formatted_board = " 1 | 2 | 3 \n" +
                      "---+---+---\n" +
                      " 4 | 5 | 6 \n" +
                      "---+---+---\n" +
                      " 7 | 8 | 9 \n" +
                      "\n"

    expect{v.display_board}.to output(formatted_board).to_stdout
  end

  it 'prints a formatted board if positions are mixed' do
    b = Board.new(3)
    b.move(5, "X")
    b.move(1, "O")
    b.move(9, "X")
    b.move(6, "O")
    v = View.new(b.to_string_array)
    formatted_board = " " + O_R + " | 2 | 3 \n" +
                      "---+---+---\n" +
                      " 4 | " + X_G + " | " + O_R + " \n" +
                      "---+---+---\n" +
                      " 7 | 8 | " + X_G + " \n" +
                      "\n"

    expect{v.display_board}.to output(formatted_board).to_stdout
  end
end


describe 'update_view' do
  it 'sets the board to the passed in array of strings' do
    b = Board.new(3)
    v = View.new(b.to_string_array)
    b.move(3, "X")
    b.move(4, "O")
    expected_array = ["" , "", "X",
                      "O", "", "",
                      "",  "", ""]

    actual_array = v.update_view(b.to_string_array)

    expect(actual_array).to eq(expected_array)
  end
end
