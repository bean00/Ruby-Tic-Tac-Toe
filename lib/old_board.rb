class Board
  @board = [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"]
  ]

  def self.move(position)
    #@board[0][0] = "x"
    #@board
    
    counter = 1

    @board.each do |row|
      row.each do |col|
        if counter == position
          col = "x"
        end
        puts col
        counter += 1
      end
    end

    puts @board
  end

end

Board.move(1)
