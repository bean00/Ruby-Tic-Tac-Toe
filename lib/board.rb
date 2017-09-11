class Board
  attr_reader :board

  def initialize(board=Array.new(9, ""))
    @board = board
  end

  def move(move, player_token)
    move_index = move - 1

    @board[move_index] = player_token
  end

  def get_available_moves
    available_moves = []

    @board.each_with_index do |pos, i|
      if pos == ""
        move = i + 1
        available_moves << move
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

  def position_is_empty?(move)
    if move.is_a? String
      move = move.to_i
    end

    move_index = move - 1
    
    @board[move_index] == ""
  end

  private

  def pad_with_spaces(char)
    char.center(3)
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
