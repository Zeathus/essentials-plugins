module GameData
  class TerrainTag
    attr_reader :swamp

    alias swamp_initialize initialize

    def initialize(hash)
      swamp_initialize(hash)
      @swamp = hash[:swamp]
    end
  end
end

GameData::TerrainTag.register({
  :id                     => :Swamp,
  :id_number              => SwampTerrainTag::TAG_ID,
  :battle_environment     => :Puddle,
  :swamp                  => true,
  :must_walk              => true,
  :land_wild_encounters   => SwampTerrainTag::SWAMP_ENCOUNTERS
})