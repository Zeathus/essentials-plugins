class Spriteset_Map
  alias sign_initialize initialize

  def initialize(map = nil)
    sign_initialize(map)
    pbUpdateSigns
  end
end
