require 'board'
require 'win_checker'
require 'tic_tac_toe_rules'

describe 'has_player_won?' do
  let(:b) { Board.new(3) }
  let(:r) { TicTacToeRules.new(3) }
  let(:w) { WinChecker.new(b, r) }

  context 'when the top row is filled' do
    it 'returns true' do
      b.move(1, "X")
      b.move(2, "X")
      b.move(3, "X")

      expect(w.has_player_won?("X")).to be true
    end
  end

  context 'when the board is empty' do
    it 'returns false' do
      expect(w.has_player_won?("X")).to be false
    end
  end

  context 'when a player has moved, but has not won yet' do
    it 'returns false' do
      b.move(1, "X")
      b.move(5, "O")
      b.move(4, "X")

      expect(w.has_player_won?("X")).to be false
    end
  end

  context 'when the middle row is filled' do
    it 'returns true' do
      b.move(4, "O")
      b.move(5, "O")
      b.move(6, "O")

      expect(w.has_player_won?("O")).to be true
    end
  end

  context 'when the bottom row is filled' do
    it 'returns true' do
      b.move(7, "X")
      b.move(8, "X")
      b.move(9, "X")

      expect(w.has_player_won?("X")).to be true
    end
  end

  context 'when the left column is filled' do
    it 'returns true' do
      b.move(1, "X")
      b.move(4, "X")
      b.move(7, "X")

      expect(w.has_player_won?("X")).to be true
    end
  end

  context 'when the middle column is filled' do
    it 'returns true' do
      b.move(2, "X")
      b.move(5, "X")
      b.move(8, "X")

      expect(w.has_player_won?("X")).to be true
    end
  end

  context 'when the right column is filled' do
    it 'returns true' do
      b.move(3, "X")
      b.move(6, "X")
      b.move(9, "X")

      expect(w.has_player_won?("X")).to be true
    end
  end

  context 'when the diagonal from the top left to the bottom right is filled' do
    it 'returns true' do
      b.move(1, "X")
      b.move(5, "X")
      b.move(9, "X")

      expect(w.has_player_won?("X")).to be true
    end
  end

  context 'when the diagonal from the top right to the bottom left is filled' do
    it 'returns true' do
      b.move(3, "X")
      b.move(5, "X")
      b.move(7, "X")

      expect(w.has_player_won?("X")).to be true
    end
  end
end
