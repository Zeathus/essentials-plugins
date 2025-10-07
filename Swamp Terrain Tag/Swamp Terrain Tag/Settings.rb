module SwampTerrainTag

  # The terrain tag used for swamp tiles.
  # Make sure this does not overlap with existing terrain tags.
  TAG_ID = 60

  # How much of a character is obscured when on a swamp tile.
  SWAMP_HEIGHT = 14

  # How far a character's sprite is lowered when on a swamp tile.
  SWAMP_DEPTH = 6

  # If true, swamp tiles can generate wild encounters from the Land encounter list.
  SWAMP_ENCOUNTERS = true

end