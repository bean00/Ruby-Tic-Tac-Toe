class Board
  attr_reader :board

  def initialize(board=Array.new(9, ""))
    @board = board
    @moves = { :tl => 0, :t => 1, :tr => 2,
               :l  => 3, :c => 4, :r  => 5,
               :bl => 6, :b => 7, :br => 8 }
  end

  def move(position_string, character)
    position = position_string.to_sym
    index = @moves[position]
    if is_valid(position)
      @board[index] = character
    end

    @board
  end

  def is_valid(move_symbol)
    move_exists(move_symbol) && position_is_empty(move_symbol)
  end

  def move_exists(move_symbol)
    @moves.has_key?(move_symbol)
  end

  def position_is_empty(move_symbol)
    move_index = @moves[move_symbol]

    @board[move_index] == ""
  end

  def to_string
    formatted_board = ""

    @board.each_with_index do |pos, i|
      formatted_board << self.class.pad_with_spaces(pos)

      if ((i + 1) % 3 != 0)
        formatted_board << "|"
      elsif i < 8
        formatted_board << "\n---+---+---\n"
      end
    end

    formatted_board
  end

  def self.pad_with_spaces(char)
    padded_char = " "
    if (char.strip.empty?)
      padded_char << " "
    else
      padded_char << char
    end
    padded_char << " "

    padded_char
  end
end
