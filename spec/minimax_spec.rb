require 'board'
require 'win_checker'
require 'score_tracker'
require 'minimax'

describe 'minimax_move_and_score' do
  before(:each) do
    @b = Board.new(3)
    @b.set_tokens_before_any_move_is_made(["X", "O"])
    w = WinChecker.new(@b.get_side_length)
    s = ScoreTracker.new(w, @b.get_player_tokens)
    @m = Minimax.new("O", "X", s)
  end

  context 'when the game ended in a draw' do
    before(:each) do
      board = [ "X", "O", "X",
                "X", "O", "O",
                "O", "X", "X"]
      @b = Board.create_from_string_array(board)
    end

    it 'returns an invalid move' do
      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(0)
    end

    it 'returns the draw score' do
      expect(@m.minimax_move_and_score(@b, "O")[:score]).to eq(0)
    end
  end

  context 'when the other player already won' do
    it 'returns the loss score' do
      board = [ "X", "O", "O",
                "", "X", "",
                "", "", "X"]
      @b = Board.create_from_string_array(board)

      expect(@m.minimax_move_and_score(@b, "O")[:score]).to eq(-1)
    end
  end

  context 'when the player just won' do
    it 'returns the win score' do
      board = [ "X", "X", "O",
                "", "O", "",
                "O", "", ""]
      @b = Board.create_from_string_array(board)

      expect(@m.minimax_move_and_score(@b, "X")[:score]).to eq(1)
    end
  end

  context 'when the player can win now (1 move left)' do
    before(:each) do
      board = [ "X", "X", "",
                "O", "O", "X",
                "O", "X", "O"]
      @b = Board.create_from_string_array(board)
    end

    it 'returns the move to win' do
      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(3)
    end

    it 'returns the win score' do
      expect(@m.minimax_move_and_score(@b, "O")[:score]).to eq(1)
    end
  end

  context 'when the player can win now (2 moves left)' do
    it 'returns the move to win' do
      board = [ "X", "", "",
                "O", "X", "O",
                "X", "X", "O"]
      @b = Board.create_from_string_array(board)

      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(3)
    end
  end

  context 'when the player cannot win (2 moves left)' do
    it 'returns the move to force a draw' do
      board = [ "X", "O", "",
                "O", "O", "X",
                "X", "X", ""]
      @b = Board.create_from_string_array(board)

      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(9)
    end
  end

  context 'when the player determines that it cannot win' do
    it 'returns the move to eventually draw' do
      board = [ "X", "", "",
                "", "O", "",
                "X", "", ""]
      @b = Board.create_from_string_array(board)

      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(4)
    end
  end
end
