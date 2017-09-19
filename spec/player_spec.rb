require 'board'
require 'player'

describe 'get_next_move' do
  let(:b) { Board.new(3) }

  context 'when the computer has 1 move left' do
    it 'returns the move' do
      new_state = ["",  "X", "O",
                   "X", "O", "X",
                   "X", "O", "O"]
      b.set_board(new_state)
      comp = Player.new(true, 1, b.to_string_array)

      expect(comp.get_next_move).to eq("1")
    end
  end

  context 'when the computer has 2 moves left' do
    it 'returns the move it chooses' do
      new_state = ["O", "",  "",
                   "X", "O", "X",
                   "X", "O", "X"]
      b.set_board(new_state)
      comp = Player.new(true, 2, b.to_string_array)

      expect(comp.get_next_move).to eq("2")
    end
  end

  context 'when a person moves to 4' do
    it 'returns the move' do
      person = Player.new(false, 1, b.to_string_array)
      allow($stdin).to receive(:gets).and_return("4\n")

      expect(person.get_next_move).to eq("4")
    end
  end
end


describe 'get_token' do
  let(:b) { Board.new(3) }

  context 'when the player is a person and he goes 1st' do
    it 'returns X' do
      person = Player.new(false, 1, b.to_string_array)

      expect(person.get_token).to eq("X")
    end
  end

  context 'when the player is a person and he goes 2nd' do
    it 'returns O' do
      person = Player.new(false, 2, b.to_string_array)

      expect(person.get_token).to eq("O")
    end
  end

  context 'when the player is a computer and it goes 1st' do
    it 'returns O' do
      comp = Player.new(true, 1, b.to_string_array)

      expect(comp.get_token).to eq("O")
    end
  end

  context 'when the player is a computer and it goes 2nd' do
    it 'returns O' do
      comp = Player.new(true, 2, b.to_string_array)

      expect(comp.get_token).to eq("O")
    end
  end
end
