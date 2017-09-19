class Player

  def initialize
    raise "Subclass must overwrite initialize"
  end

  def get_next_move
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end

  def get_token
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end

end
