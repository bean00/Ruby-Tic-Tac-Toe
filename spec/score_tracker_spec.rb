require 'board'
require 'win_checker'
require 'score_tracker'

WIN_SCORE = ScoreTracker::WIN_SCORE
LOSS_SCORE = ScoreTracker::LOSS_SCORE
DRAW_SCORE = ScoreTracker::DRAW_SCORE
INCOMPLETE_GAME = ScoreTracker::INCOMPLETE_GAME

describe 'get_player_score' do
  context 'when the game first starts (Player 1 is X)' do
    before(:each) do
      @b = Board.new(3)
      tokens = ["X", "O"]
      @b.set_tokens_before_any_move_is_made(tokens)
      @s = ScoreTracker.new(@b)
    end

    it 'returns incomplete game score for Player 1 (P1)' do
      expect(@s.get_player_score("X")).to eq(INCOMPLETE_GAME)
    end

    it 'returns incomplete game score for Player 2 (P2)' do
      expect(@s.get_player_score("O")).to eq(INCOMPLETE_GAME)
    end
  end

  context 'when Player 1 (X) wins and the board is not full yet' do
    before(:each) do
      @b = Board.create_from_string_array(
        ["X", "X", "X",
         "",  "O", "",
         "",  "O",  "" ])
      @s = ScoreTracker.new(@b)
      @s.update_scores("X")
    end

    it 'returns win score for P1' do
      expect(@s.get_player_score("X")).to eq(WIN_SCORE)
    end

    it 'returns loss score for P2' do
      expect(@s.get_player_score("O")).to eq(LOSS_SCORE)
    end
  end

  context 'when Player 2 (O) wins and the board is not full yet' do
    before(:each) do
      @b = Board.create_from_string_array(
        ["X", "X", "O",
         "X", "O", "",
         "O", "",  "" ])
      @s = ScoreTracker.new(@b)
      @s.update_scores("O")
    end

    it 'returns win score for P2' do
      expect(@s.get_player_score("O")).to eq(WIN_SCORE)
    end

    it 'returns loss score for P1' do
      expect(@s.get_player_score("X")).to eq(LOSS_SCORE)
    end
  end

  context 'when neither player has won and there are still moves left' do
    before(:each) do
      @b = Board.create_from_string_array(
        ["X", "X", "O",
         "X", "O", "",
         "",  "O", "" ])
      @s = ScoreTracker.new(@b)
      @s.update_scores("O")
    end

    it 'returns incomplete game score for P1 (X)' do
      expect(@s.get_player_score("X")).to eq(INCOMPLETE_GAME)
    end

    it 'returns incomplete game score for P2 (O)' do
      expect(@s.get_player_score("O")).to eq(INCOMPLETE_GAME)
    end
  end

  context 'when Player 1 (X) draws' do
    before(:each) do
      @b = Board.create_from_string_array(
        ["X", "O", "X",
         "X", "X", "O",
         "O", "X", "O"])
      @s = ScoreTracker.new(@b)
      @s.update_scores("X")
    end

    it 'returns draw score for P1' do
      expect(@s.get_player_score("X")).to eq(DRAW_SCORE)
    end

    it 'returns draw score for P2' do
      expect(@s.get_player_score("O")).to eq(DRAW_SCORE)
    end
  end

  context 'when Player 1 (X) wins on the last move' do
    before(:each) do
      @b = Board.create_from_string_array(
        ["X", "O", "X",
         "X", "X", "O",
         "O", "O", "X"])
      @s = ScoreTracker.new(@b)
      @s.update_scores("X")
    end

    it 'returns win score for P1' do
      expect(@s.get_player_score("X")).to eq(WIN_SCORE)
    end

    it 'returns loss score for P2' do
      expect(@s.get_player_score("O")).to eq(LOSS_SCORE)
    end
  end
end


describe 'is_game_finished?' do
  context 'when the game just started' do
    it 'returns false' do
      b = Board.new(3)
      s = ScoreTracker.new(b)
      expect(s.is_game_finished?).to eq false
    end
  end

  context 'when Player 1 (X) has won and there are still moves left' do
    it 'returns true' do
      b = Board.create_from_string_array(
        ["X", "X", "X",
         "O", "O", "",
         "",  "",  ""])
      s = ScoreTracker.new(b)
      s.update_scores("X")

      expect(s.is_game_finished?).to eq true
    end
  end

  context 'when Player 2 (O) has won and there are still moves left' do
    it 'returns true' do
      b = Board.create_from_string_array(
        ["X", "X", "O",
         "X", "O", "",
         "O", "",  ""])
      s = ScoreTracker.new(b)
      s.update_scores("O")

      expect(s.is_game_finished?).to eq true
    end
  end

  context 'when the players have made moves but nobody has won yet' do
    it 'returns false' do
      b = Board.create_from_string_array(
        ["X", "O", "X",
         "",  "",  "",
         "",  "",  ""])
      s = ScoreTracker.new(b)
      s.update_scores("X")

      expect(s.is_game_finished?).to eq false
    end
  end

  context 'when Player 1 (X) draws' do
    it 'returns true' do
      b = Board.create_from_string_array(
        ["X", "O", "X",
         "X", "X", "O",
         "O", "X", "O"])
      s = ScoreTracker.new(b)
      s.update_scores("X")

      expect(s.is_game_finished?).to eq true
    end
  end

  context 'when Player 1 (X) wins on the last move' do
    it 'returns true' do
      b = Board.create_from_string_array(
        ["X", "O", "X",
         "X", "X", "O",
         "O", "O", "X"])
      s = ScoreTracker.new(b)
      s.update_scores("X")

      expect(s.is_game_finished?).to eq true
    end
  end
end


describe 'has_either_player_won?' do
  let(:b) { Board.new(3) }
  let(:s) { ScoreTracker.new(b) }
  
  context 'when the game just started' do
    it 'returns false' do
      expect(s.has_either_player_won?).to eq false
    end
  end

  context 'when Player 1 (X) has won' do
    it 'returns true' do
      b.move(1, "X")
      b.move(2, "X")
      b.move(3, "X")
      s.update_scores("X")

      expect(s.has_either_player_won?).to eq true
    end
  end
end
