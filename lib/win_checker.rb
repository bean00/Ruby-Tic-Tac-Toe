require_relative 'tic_tac_toe_rules'

class WinChecker

  def initialize(rules)
    @rules = rules
    @full_sets = get_full_sets
  end

  def has_player_won?(token, board)
    player_moves_set = board.get_move_set_for_player(token)

    @full_sets.any? { |full_set|
      full_set.subset?(player_moves_set) 
    }
  end

  private

  def get_full_sets
    @rules.get_all_full_sets
  end

end
