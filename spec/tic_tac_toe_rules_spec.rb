require 'tic_tac_toe_rules'

describe 'get_all_full_sets' do
  context 'with a board of side length 3' do
    it 'returns all sets for rows, columns, and diagonals' do
      t = TicTacToeRules.new(3)
      expected_sets = [
        [1, 2, 3].to_set, [4, 5, 6].to_set, [7, 8, 9].to_set,
        [1, 4, 7].to_set, [2, 5, 8].to_set, [3, 6, 9].to_set,
        [1, 5, 9].to_set, [3, 5, 7].to_set
      ]

      all_sets = t.get_all_full_sets

      expect(all_sets).to eq(expected_sets)
    end
  end
end


describe 'get_full_rows' do
  context 'with a board of side length 3' do
    it 'returns all sets for full rows' do
      t = TicTacToeRules.new(3)
      expected_rows = [
        [1, 2, 3].to_set,
        [4, 5, 6].to_set,
        [7, 8, 9].to_set
      ]

      full_rows = t.get_full_rows

      expect(full_rows).to eq(expected_rows)
    end
  end

  context 'with a board of side length 4' do
    it 'returns all sets for full rows' do
      t = TicTacToeRules.new(4)
      expected_rows = [
        [1,  2,  3,  4].to_set,
        [5,  6,  7,  8].to_set,
        [9,  10, 11, 12].to_set,
        [13, 14, 15, 16].to_set
      ]

      full_rows = t.get_full_rows

      expect(full_rows).to eq(expected_rows)
    end
  end
end


describe 'get_full_columns' do
  context 'with a board of side length 3' do
    it 'returns all sets for full columns' do
      t = TicTacToeRules.new(3)
      expected_columns = [
        [1, 4, 7].to_set,
        [2, 5, 8].to_set,
        [3, 6, 9].to_set
      ]

      full_columns = t.get_full_columns

      expect(full_columns).to eq(expected_columns)
    end
  end

  context 'with a board of side length 4' do
    it 'returns all sets for full columns' do
      t = TicTacToeRules.new(4)
      expected_columns = [
        [1, 5, 9,  13].to_set,
        [2, 6, 10, 14].to_set,
        [3, 7, 11, 15].to_set,
        [4, 8, 12, 16].to_set
      ]

      full_columns = t.get_full_columns

      expect(full_columns).to eq(expected_columns)
    end
  end
end


describe 'get_full_diagonals' do
  context 'with a board of side length 3' do
    it 'returns all sets for full diagonals' do
      t = TicTacToeRules.new(3)
      expected_diagonals = [
        [1, 5, 9].to_set,
        [3, 5, 7].to_set 
      ]

      full_diagonals = t.get_full_diagonals

      expect(full_diagonals).to eq(expected_diagonals)
    end
  end
  
  context 'with a board of side length 4' do
    it 'returns all sets for full diagonals' do
      t = TicTacToeRules.new(4)
      expected_diagonals = [
        [1, 6, 11, 16].to_set,
        [4, 7, 10, 13].to_set 
      ]

      full_diagonals = t.get_full_diagonals

      expect(full_diagonals).to eq(expected_diagonals)
    end
  end
end
