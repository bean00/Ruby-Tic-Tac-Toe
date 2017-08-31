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
  end

  def get_available_moves
    available_moves = []

    @board.each_with_index do |pos, i|
      if pos == ""
        move_symbol = @moves.key(i)
        move_string = move_symbol.to_s
        available_moves << move_string
      end
    end

    available_moves
  end

  def to_string
    formatted_board = ""

    @board.each_with_index do |pos, i|
      formatted_board << pad_with_spaces(pos)
      formatted_board << add_divider(i)
    end

    formatted_board
  end

  private

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

  def pad_with_spaces(char)
    padded_char = " "

    if (char.strip.empty?)
      padded_char << " "
    else
      padded_char << char
    end
    padded_char << " "

    padded_char
  end

  def add_divider(index)
    divider = ""
    
    if ((index + 1) % 3 != 0)
      divider = "|"
    elsif index < 8
      divider = "\n---+---+---\n"
    end
    
    divider
  end

end
