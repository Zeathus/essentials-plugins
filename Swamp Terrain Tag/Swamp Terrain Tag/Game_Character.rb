class Game_Character

  alias swamp_calculate_bush_depth calculate_bush_depth
  alias swamp_screen_y screen_y

  def calculate_bush_depth
    swamp_calculate_bush_depth
    if @tile_id <= 0 && !@always_on_top && !jumping?
      this_map = (self.map.valid?(@x, @y)) ? [self.map, @x, @y] : $map_factory&.getNewMap(@x, @y, self.map.map_id)
      if this_map && this_map[0].swamp?(this_map[1], this_map[2])
        xbehind = @x + (@direction == 4 ? 1 : @direction == 6 ? -1 : 0)
        ybehind = @y + (@direction == 8 ? 1 : @direction == 2 ? -1 : 0)
        if moving?
          behind_map = (self.map.valid?(xbehind, ybehind)) ? [self.map, xbehind, ybehind] : $map_factory&.getNewMap(xbehind, ybehind, self.map.map_id)
          @bush_depth = SwampTerrainTag::SWAMP_HEIGHT if behind_map[0].swamp?(behind_map[1], behind_map[2])
        else
          @bush_depth = SwampTerrainTag::SWAMP_HEIGHT
        end
      end
    end
  end

  def screen_y
    ret = swamp_screen_y
    if !jumping?
      this_map = (self.map.valid?(@x, @y)) ? [self.map, @x, @y] : $map_factory&.getNewMap(@x, @y)
      if this_map[0].swamp?(this_map[1], this_map[2]) && @bush_depth > 0
        ret += SwampTerrainTag::SWAMP_DEPTH
      end
    end
    return ret
  end

end