require_relative 'tic_tac_toe_rules'

class WinChecker

  def initialize(board, rules)
    @board = board
    @rules = rules
    @full_sets = get_full_sets(@board.get_side_length)
  end

  def has_player_won?(token)
    player_moves_set = @board.get_move_set_for_player(token)

    @full_sets.any? { |full_set|
      full_set.subset?(player_moves_set) 
    }
  end

  private

  def get_full_sets(side_length)
    @rules.get_all_full_sets
  end

end
