require 'board'
require 'score_tracker'

describe 'has_player_won?' do
  let(:b) { Board.new(3) }

  context 'when the top row is filled' do
    it 'returns true' do
      b.move(1, "X")
      b.move(2, "X")
      b.move(3, "X")

      player_won = ScoreTracker.has_player_won?(b.to_string_array, "X")

      expect(player_won).to be true
    end
  end

  context 'when the board is empty' do
    it 'returns false' do
      player_won = ScoreTracker.has_player_won?(b.to_string_array, "X")

      expect(player_won).to be false
    end
  end

  context 'when the middle row is filled' do
    it 'returns true' do
      b.move(4, "O")
      b.move(5, "O")
      b.move(6, "O")

      player_won = ScoreTracker.has_player_won?(b.to_string_array, "O")

      expect(player_won).to be true
    end
  end

  context 'when the bottom row is filled' do
    it 'returns true' do
      b.move(7, "X")
      b.move(8, "X")
      b.move(9, "X")

      player_won = ScoreTracker.has_player_won?(b.to_string_array, "X")

      expect(player_won).to be true
    end
  end

  context 'when the left column is filled' do
    it 'returns true' do
      b.move(1, "X")
      b.move(4, "X")
      b.move(7, "X")

      player_won = ScoreTracker.has_player_won?(b.to_string_array, "X")

      expect(player_won).to be true
    end
  end

  context 'when the middle column is filled' do
    it 'returns true' do
      b.move(2, "X")
      b.move(5, "X")
      b.move(8, "X")

      player_won = ScoreTracker.has_player_won?(b.to_string_array, "X")

      expect(player_won).to be true
    end
  end

  context 'when the right column is filled' do
    it 'returns true' do
      b.move(3, "X")
      b.move(6, "X")
      b.move(9, "X")
      
      player_won = ScoreTracker.has_player_won?(b.to_string_array, "X")

      expect(player_won).to be true
    end
  end

  context 'when the diagonal from the "tl" to "br" is filled' do
    it 'returns true' do
      b.move(1, "X")
      b.move(5, "X")
      b.move(9, "X")

      player_won = ScoreTracker.has_player_won?(b.to_string_array, "X")

      expect(player_won).to be true
    end
  end

  context 'when the diagonal from the "tr" to "bl" is filled' do
    it 'returns true' do
      b.move(3, "X")
      b.move(5, "X")
      b.move(7, "X")

      player_won = ScoreTracker.has_player_won?(b.to_string_array, "X")
      
      expect(player_won).to be true
    end
  end
end
