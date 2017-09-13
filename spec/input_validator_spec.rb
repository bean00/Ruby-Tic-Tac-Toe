require 'input_validator'
require 'board'

describe 'is_move_valid?' do
  it 'returns true for a valid integer ("3")' do
    b = Board.new(3)
    i = InputValidator.new(b.to_string_array)

    move_is_valid = i.is_move_valid?("3")

    expect(move_is_valid).to be true
  end

  it 'returns false for a single letter ("a")' do
    b = Board.new(3)
    i = InputValidator.new(b.to_string_array)

    move_is_valid = i.is_move_valid?("a")

    expect(move_is_valid).to be false
  end

  it 'returns false for an out-of-bounds integer below the limit ("-5")' do
    b = Board.new(3)
    i = InputValidator.new(b.to_string_array)

    move_is_valid = i.is_move_valid?("-5")

    expect(move_is_valid).to be false
  end

  it 'returns false for an out-of-bounds integer above the limit ("11")' do
    b = Board.new(3)
    i = InputValidator.new(b.to_string_array)

    move_is_valid = i.is_move_valid?("11")

    expect(move_is_valid).to be false
  end

  it 'returns false for a string has integer and other characters ("4ea")' do
    b = Board.new(3)
    i = InputValidator.new(b.to_string_array)

    move_is_valid = i.is_move_valid?("4ea")

    expect(move_is_valid).to be false
  end
end


describe 'is_position_empty?' do
  it 'returns true for an empty position' do
    b = Board.new(3)
    b.move(4, "X")
    b.move(5, "O")
    i = InputValidator.new(b.to_string_array)

    position_is_empty = i.is_position_empty?("2")

    expect(position_is_empty).to be true
  end

  it 'returns false for a position that was taken' do
    b = Board.new(3)
    b.move(6, "X")
    i = InputValidator.new(b.to_string_array)

    position_is_empty = i.is_position_empty?("6")

    expect(position_is_empty).to be false
  end
end
