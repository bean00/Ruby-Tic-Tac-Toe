require 'board'
require 'player'
require 'human_player'
require 'computer_player'

describe 'to_string_array' do
  let(:b) { Board.new(3) }

  context 'with an empty board' do
    it 'returns an empty array of strings' do
      board_str = ["", "", "",
                   "", "", "",
                   "", "", ""]

      expect(b.to_string_array).to eq(board_str)
    end
  end

  context 'when 1 move has been made' do
    it 'returns an array with 1 string' do
      b.move(1, "X")
      board_str = ["X", "", "",
                   "",  "", "",
                   "",  "", ""]

      expect(b.to_string_array).to eq(board_str)
    end
  end

  context 'when 2 moves have been made' do
    it 'returns an array with 2 strings' do
      b.move(1, "X")
      b.move(6, "O")
      board_str = ["X", "", "",
                   "",  "", "O",
                   "",  "", ""]

      expect(b.to_string_array).to eq(board_str)
    end
  end

  context 'with a full board' do
    it 'returns a full array' do
      b.move(1, "X")
      b.move(2, "O")
      b.move(3, "X")
      b.move(4, "O")
      b.move(5, "X")
      b.move(6, "O")
      b.move(7, "X")
      b.move(8, "O")
      b.move(9, "X")
      board_str = ["X", "O", "X",
                   "O", "X", "O",
                   "X", "O", "X"]

      expect(b.to_string_array).to eq(board_str)
    end
  end
end


describe 'move' do
  let(:b) { Board.new(3) }

  context 'when a player moves' do
    [[1, ["X", "",  "",
          "",  "",  "",
          "",  "",  ""]],
     [2, ["",  "X", "",
          "",  "",  "",
          "",  "",  ""]],
     [9, ["",  "",  "",
          "",  "",  "",
          "",  "",  "X"]]
    ].each do |move, board_after_move|
      it "sets position #{move}" do
        b.move(move, "X")

        expect(b.to_string_array).to eq(board_after_move)
      end
    end
  end

  context 'when the second player moves' do
    it 'sets position 2 next' do
      b.move(1, "X")
      board_after_move = ["X", "O", "",
                          "",  "",  "",
                          "",  "",  ""]

      b.move(2, "O")

      expect(b.to_string_array).to eq(board_after_move)
    end
  end
end


describe 'get_available_moves' do
  let(:b) { Board.new(3) }

  context 'when no move has been made yet' do
    it 'returns all moves' do
      array_with_all_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]

      expect(b.get_available_moves).to eq(array_with_all_moves)
    end
  end

  context 'when there is 1 move left' do
    it 'returns that move' do
      b.move(1, "X")
      b.move(3, "O")
      b.move(4, "X")
      b.move(6, "O")
      b.move(5, "X")
      b.move(7, "O")
      b.move(8, "X")
      b.move(9, "O")
      expected_array = [2]

      expect(b.get_available_moves).to eq(expected_array)
    end
  end

  context 'when 5 moves have been made' do
    it 'returns the other 4 moves' do
      b.move(2, "X")
      b.move(3, "O")
      b.move(4, "X")
      b.move(5, "O")
      b.move(7, "X")
      array_with_moves = [1, 6, 8, 9]

      expect(b.get_available_moves).to eq(array_with_moves)
    end
  end
end


describe 'set_board' do
  let(:b) { Board.new(3) }

  context 'when passing in an empty board' do
    it 'sets the board correctly' do
      new_board = ["", "", "",
                   "", "", "",
                   "", "", ""]

      b.set_board(new_board)

      expect(b.to_string_array).to eq(new_board)
    end
  end

  context 'when passing in a board' do
    it 'sets the board correctly' do
      new_board = ["", "X", "",
                   "", "O", "",
                   "", "X", ""]

      b.set_board(new_board)

      expect(b.to_string_array).to eq(new_board)
    end
  end
end


describe 'get_side_length' do
  context 'when a 3x3 board has been created' do
    it 'returns the side length' do
      b = Board.new(3)

      expect(b.get_side_length).to eq(3)
    end
  end

  context 'when a 4x4 board has been created' do
    it 'returns the side length' do
      b = Board.new(4)

      expect(b.get_side_length).to eq(4)
    end
  end
end


describe 'get_move_set_for_player' do
  let(:b) { Board.new(3) } 

  context 'when a player has made 3 moves' do
    it 'returns the move set' do
      b.move(1, "X")
      b.move(2, "O")
      b.move(4, "X")
      b.move(3, "O")
      b.move(5, "X")
      expected_move_set = [1, 4, 5].to_set

      expect(b.get_move_set_for_player("X")).to eq(expected_move_set)
    end
  end

  context 'when a player has not moved yet' do
    it 'returns an empty set' do
      expected_move_set = [].to_set

      expect(b.get_move_set_for_player("X")).to eq(expected_move_set)
    end
  end
end


describe 'number_of_moves_left' do
  let(:b) { Board.new(3) }

  context 'when the game just started on a 3x3 board' do
    it 'returns 9' do
      expect(b.number_of_moves_left).to eq(9)
    end
  end

  context 'when 4 moves have been made on a 3x3 board' do
    it 'returns 5' do
      b.move(1, "X")
      b.move(2, "O")
      b.move(3, "X")
      b.move(4, "O")

      expect(b.number_of_moves_left).to eq(5)
    end
  end

  context 'when 1 move has been made on a 3x3 board' do
    it 'returns 8' do
      b.move(5, "O")

      expect(b.number_of_moves_left).to eq(8)
    end
  end

  context 'when all moves have been made on a 3x3 board' do
    it 'returns 0' do
      board = ["X", "O", "X",
               "X", "X", "O",
               "O", "X", "O"]
      b.set_board(board)

      expect(b.number_of_moves_left).to eq(0)
    end
  end
end


describe 'get_player_tokens' do
  let(:b) { Board.new(3) }

  context 'when 4 moves have been made (without setting the tokens)' do
    it 'returns both tokens' do
      b.move(1, "O")
      b.move(2, "X")
      b.move(5, "O")
      b.move(3, "X")

      expect(b.get_player_tokens).to eq(["O", "X"])
    end
  end

  context 'when no moves have been made (with setting the tokens)' do
    it 'returns both tokens' do
      h = HumanPlayer.new(1, b)
      c = ComputerPlayer.new(2, b)
      tokens = [h.get_token, c.get_token]
      b.set_tokens_before_any_move_is_made(tokens)

      expect(b.get_player_tokens).to eq(["X", "O"])
    end
  end
end
