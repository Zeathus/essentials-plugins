class Game_Character
  attr_accessor :proximity_texts

  alias sign_initialize initialize

  def initialize(map = nil)
    sign_initialize(map)
    @proximity_texts = {}
  end

  def proximity_texts
    @proximity_texts = {} if !@proximity_texts
    return @proximity_texts
  end

end
