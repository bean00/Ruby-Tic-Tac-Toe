require 'input_validator'

describe 'is_move_valid?' do
  it 'returns true for a valid integer ("3")' do
    i = InputValidator.new(9)

    move_is_valid = i.is_move_valid?("3")

    expect(move_is_valid).to be true
  end

  it 'returns false for a single letter ("a")' do
    i = InputValidator.new(9)

    move_is_valid = i.is_move_valid?("a")

    expect(move_is_valid).to be false
  end

  it 'returns false for an out-of-bounds integer below the limit ("-5")' do
    i = InputValidator.new(9)

    move_is_valid = i.is_move_valid?("-5")

    expect(move_is_valid).to be false
  end

  it 'returns false for an out-of-bounds integer above the limit ("11")' do
    i = InputValidator.new(9)

    move_is_valid = i.is_move_valid?("11")

    expect(move_is_valid).to be false
  end

  it 'returns false for a string has integer and other characters ("4ea")' do
    i = InputValidator.new(9)

    move_is_valid = i.is_move_valid?("4ea")

    expect(move_is_valid).to be false
  end
end
