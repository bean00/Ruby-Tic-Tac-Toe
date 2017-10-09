require 'board'
require 'score_tracker'
require 'tic_tac_toe_rules'
require 'win_checker'
require 'minimax'

WIN_SCORE = ScoreTracker::WIN_SCORE
LOSS_SCORE = ScoreTracker::LOSS_SCORE
DRAW_SCORE = ScoreTracker::DRAW_SCORE

describe 'minimax_move_and_score' do
  context 'when the game ended in a draw' do
    before(:each) do
      board = ["X", "O", "X",
               "X", "O", "O",
               "O", "X", "X"]
      
      @b = Board.create_from_string_array(board)
      @s = ScoreTracker.new(@b)
      @m = Minimax.new("O", "X", @s)
    end

    it 'returns an invalid move' do
      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(0)
    end

    it 'returns the draw score' do
      expect(@m.minimax_move_and_score(@b, "O")[:score]).to eq(DRAW_SCORE)
    end
  end

  context 'when the other player already won' do
    before(:each) do
      board = ["X", "O", "O",
               "",  "X", "",
               "",  "",  "X"]

      @b = Board.create_from_string_array(board)
      @s = ScoreTracker.new(@b)
      @m = Minimax.new("O", "X", @s)
    end

    it 'returns an invalid move' do
      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(0)
    end

    it 'returns the loss score' do
      expect(@m.minimax_move_and_score(@b, "O")[:score]).to eq(LOSS_SCORE)
    end
  end

  context 'when the player just won' do
    before(:each) do
      board = ["X", "X", "O",
               "",  "O", "",
               "O", "",  "X"]

      @b = Board.create_from_string_array(board)
      @s = ScoreTracker.new(@b)
      @m = Minimax.new("O", "X", @s)
    end

    it 'returns an invalid move' do
      expect(@m.minimax_move_and_score(@b, "X")[:move]).to eq(0)
    end

    it 'returns the win score' do
      expect(@m.minimax_move_and_score(@b, "X")[:score]).to eq(WIN_SCORE)
    end
  end

  context 'when the player can win now (1 move left)' do
    before(:each) do
      board = ["X", "X", "",
               "O", "O", "X",
               "O", "X", "O"]

      @b = Board.create_from_string_array(board)
      @s = ScoreTracker.new(@b)
      @m = Minimax.new("X", "O", @s)
    end

    it 'returns the move to win' do
      expect(@m.minimax_move_and_score(@b, "X")[:move]).to eq(3)
    end

    it 'returns the win score' do
      expect(@m.minimax_move_and_score(@b, "X")[:score]).to eq(WIN_SCORE)
    end
  end

  context 'when the player can win now (2 moves left)' do
    before(:each) do
      board = ["X", "",  "",
               "O", "X", "O",
               "X", "X", "O"]

      @b = Board.create_from_string_array(board)
      @s = ScoreTracker.new(@b)
      @m = Minimax.new("O", "X", @s)
    end

    it 'returns the move to win' do
      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(3)
    end

    it 'returns the win score' do
      expect(@m.minimax_move_and_score(@b, "O")[:score]).to eq(WIN_SCORE)
    end
  end

  context "when the player can't win (2 moves left)" do
    before(:each) do
      board = ["X", "O", "",
               "O", "O", "X",
               "X", "X", ""]

      @b = Board.create_from_string_array(board)
      @s = ScoreTracker.new(@b)
      @m = Minimax.new("O", "X", @s)
    end

    it 'returns the move to force a draw' do
      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(9)
    end

    it 'returns the draw score' do
      expect(@m.minimax_move_and_score(@b, "O")[:score]).to eq(DRAW_SCORE)
    end
  end

  context "when the player determines that it can't win" do
    before(:each) do
      board = ["X", "",  "",
               "",  "O", "",
               "X", "",  ""]

      @b = Board.create_from_string_array(board)
      @s = ScoreTracker.new(@b)
      @m = Minimax.new("O", "X", @s)
    end

    it 'returns the move to eventually draw' do
      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(4)
    end

    it 'returns the draw score' do
      expect(@m.minimax_move_and_score(@b, "O")[:score]).to eq(DRAW_SCORE)
    end
  end

  context 'when the player determines that it can win' do
    before(:each) do
      board = ["", "",  "O",
               "", "",  "X",
               "", "X", "O"]

      @b = Board.create_from_string_array(board)
      @s = ScoreTracker.new(@b)
      @m = Minimax.new("O", "X", @s)
    end

    it 'returns the move to eventually win' do
      expect(@m.minimax_move_and_score(@b, "O")[:move]).to eq(1)
    end

    it 'returns the win score' do
      expect(@m.minimax_move_and_score(@b, "O")[:score]).to eq(WIN_SCORE)
    end
  end
end

