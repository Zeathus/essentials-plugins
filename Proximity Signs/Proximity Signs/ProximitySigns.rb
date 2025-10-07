def pbLoadSigns
  return if !$Signs || !$Signs[$game_map.map_id]
  for sign in $Signs[$game_map.map_id]
    next if !sign || sign.length < 4
    event = $game_map.events[sign[0]]
    next if !event
    page = sign[1]
    next if event.page_number != page
    direction = sign[2]
    text = sign[3]
    text.gsub!("\\rightarrow", "→")
    text.gsub!("\\leftarrow", "←")
    text.gsub!("\\downarrow", "↓")
    text.gsub!("\\uparrow", "↑")
    base = ProximitySigns::TEXT_MAIN_COLOR
    shadow = ProximitySigns::TEXT_SHADOW_COLOR
    text = _INTL("<c2={1}{2}>{3}</c2>",
      base.to_rgb15.to_s,
      shadow.to_rgb15.to_s,
      text
    )
    event.proximity_texts[direction] = text
  end
end

def pbUnloadSigns
  for e in $game_map.events.values
    e.proximity_texts = {}
  end
end

def pbUpdateSigns
  pbUnloadSigns
  pbLoadSigns
end

# Update signs on map change
EventHandlers.add(:on_map_or_spriteset_change, :update_proximity_signs,
  proc { |scene, map_changed|
    next if !scene || !scene.spriteset
    pbUpdateSigns
  }
)