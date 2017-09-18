require 'input_validator'
require 'board'

describe 'is_move_valid?' do
  let(:b) { Board.new(3) }
  let(:i) { InputValidator.new(b.to_string_array) }

  context 'with a valid integer ("3")' do
    it 'returns true' do
      expect(i.is_move_valid?("3")).to be true
    end
  end

  context 'with a single letter ("a")' do
    it 'returns false' do
      expect(i.is_move_valid?("a")).to be false
    end
  end

  context 'with an out-of-bounds integer below the limit ("-5")' do
    it 'returns false' do
      expect(i.is_move_valid?("-5")).to be false
    end
  end

  context 'with an out-of-bounds integer above the limit ("11")' do
    it 'returns false' do
      expect(i.is_move_valid?("11")).to be false
    end
  end

  context 'with a string that has an integer and other characters ("4ea")' do
    it 'returns false' do
      expect(i.is_move_valid?("4ea")).to be false
    end
  end
end


describe 'is_position_empty?' do
  let(:b) { Board.new(3) }

  context 'with an empty position' do
    it 'returns true' do
      b.move(4, "X")
      b.move(5, "O")
      i = InputValidator.new(b.to_string_array)

      expect(i.is_position_empty?("2")).to be true
    end
  end

  context 'with a position that was taken' do
    it 'returns false' do
      b.move(6, "X")
      i = InputValidator.new(b.to_string_array)

      expect(i.is_position_empty?("6")).to be false
    end
  end
end
