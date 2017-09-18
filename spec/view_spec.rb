require 'board'
require 'view'

describe 'display_board' do
  let(:b) { Board.new(3) }

  context 'when all positions are "x"s' do
    it 'displays a formatted board' do
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
  end

  context 'when all positions are empty' do
    it 'displays a formatted board' do
      v = View.new(b.to_string_array)
      formatted_board = " 1 | 2 | 3 \n" +
                        "---+---+---\n" +
                        " 4 | 5 | 6 \n" +
                        "---+---+---\n" +
                        " 7 | 8 | 9 \n" +
                        "\n"

      expect{v.display_board}.to output(formatted_board).to_stdout
    end
  end

  context 'when positions are mixed' do
    it 'displays a formatted board' do
      b.move(5, "X")
      b.move(1, "O")
      b.move(9, "X")
      b.move(6, "O")
      v = View.new(b.to_string_array)
      formatted_board = " O | 2 | 3 \n" +
                        "---+---+---\n" +
                        " 4 | X | O \n" +
                        "---+---+---\n" +
                        " 7 | 8 | X \n" +
                        "\n"

      expect{v.display_board}.to output(formatted_board).to_stdout
    end
  end
end


describe 'update_view' do
  context 'when an array of strings is passed in' do
    it 'sets the board' do
      b = Board.new(3)
      v = View.new(b.to_string_array)
      b.move(3, "X")
      b.move(4, "O")
      board_array = b.to_string_array
      expected_array = ["" , "", "X",
                        "O", "", "",
                        "",  "", ""]

      expect(v.update_view(board_array)).to eq(expected_array)
    end
  end
end
