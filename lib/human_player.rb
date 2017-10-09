require_relative 'player'

class HumanPlayer < Player

  def initialize(token, io_handler)
    @token = token
    @io_handler = io_handler
  end

  def get_next_move(board)
    @io_handler.get_valid_move(board.to_string_array)
  end

  def get_token
    @token
  end

end
