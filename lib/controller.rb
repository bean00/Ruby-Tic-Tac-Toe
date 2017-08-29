require_relative 'board'
require_relative 'score_tracker'

class Controller

  def initialize(board)
    @board = board
  end

  def display_instructions
    puts "This is a Tic Tac Toe program."
    puts "Please enter your move:\n" +
      "Top left  -> 'tl'\n" +
      "Top       -> 't'\n" +
      "Top right -> 'tr'\n" +
      "\n"
  end


end
