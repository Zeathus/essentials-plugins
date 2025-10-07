class Game_Map
  
  def swamp?(x, y)
    [2, 1, 0].each do |i|
      tile_id = data[x, y, i]
      terrain = GameData::TerrainTag.try_get(@terrain_tags[tile_id])
      return false if terrain.bridge && $PokemonGlobal.bridge > 0
      return true if terrain.swamp
    end
    return false
  end

end