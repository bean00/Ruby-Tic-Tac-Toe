class Board

  def initialize(side_length)
    @side_length = side_length
    @all_moves = set_all_moves(@side_length)
    @player_moves = Hash.new
  end

  def to_string_array
    string_array = Array.new(@all_moves.size, "")

    @player_moves.each do |token, moves_set|
      assign_moves_to_array(string_array, token, moves_set)
    end

    string_array
  end

  def move(move, player_token)
    if !@player_moves.has_key?(player_token)
      @player_moves[player_token] = Set.new [move] 
    else
      @player_moves[player_token].add(move)
    end
  end

  def get_available_moves
    available_moves_set = @all_moves

    @player_moves.each do |token, moves_set|
      available_moves_set -= moves_set
    end
    
    available_moves_set.to_a
  end

  def set_board(board_string_array)
    board_string_array.each_with_index do |token, index|
      move(index + 1, token) if (token != "")
    end
  end

  def get_side_length
    @side_length
  end

  def get_move_set_for_player(token)
    if @player_moves[token]
      @player_moves[token]
    else
      [].to_set
    end
  end

  def number_of_moves_left
    num_moves_left = @all_moves.size

    if !@player_moves.empty?
      player_moves_sets = @player_moves.values
      player_moves_sets.map { |set|
        num_moves_left -= set.size
      }
    end

    num_moves_left
  end

  def set_tokens_before_any_move_is_made(tokens)
    @player_moves = { tokens[0] => Set.new, tokens[1] => Set.new }
  end

  def get_player_tokens
    @player_moves.keys
  end

  private

  def set_all_moves(side_length)
    lowest_move = 1
    highest_move = side_length * side_length
    move_array = (lowest_move..highest_move).to_a
    move_array.to_set
  end

  def assign_moves_to_array(string_array, token, moves_set)
    moves_array = moves_set.to_a

    moves_array.each do |move|
      string_array[move - 1] = token
    end
  end

end
