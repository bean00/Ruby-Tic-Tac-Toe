class Board
  attr_reader :board

  def initialize(board=Array.new(9, ""))
    @board = board
    @moves = { :tl => 0, :t => 1, :tr => 2,
               :l  => 3, :c => 4, :r  => 5,
               :bl => 6, :b => 7, :br => 8 }
  end

  def move(move, player_token)
    index = @moves[move]

    @board[index] = player_token
  end

  def get_available_moves
    available_moves = []

    @board.each_with_index do |pos, i|
      if pos == ""
        move = @moves.key(i)
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

  def is_valid?(move)
    move_exists?(move) && position_is_empty?(move)
  end

  def move_exists?(move)
    @moves.has_key?(move)
  end

  def position_is_empty?(move)
    move_index = @moves[move]
    
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
