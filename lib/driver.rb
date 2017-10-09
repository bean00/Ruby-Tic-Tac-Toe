require_relative 'board'
require_relative 'controller'

b = Board.new(3)
c = Controller.new(b)

c.play_game
