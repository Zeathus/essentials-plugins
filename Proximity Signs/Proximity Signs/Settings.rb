module ProximitySigns

  # If set to nil, just uses the message box default.
  # Uses full path, e.g. Graphics/Windowskins/skin
  WINDOW_SKIN = nil

  # Text color to use on signs
  TEXT_MAIN_COLOR   = MessageConfig::DARK_TEXT_MAIN_COLOR
  TEXT_SHADOW_COLOR = MessageConfig::DARK_TEXT_SHADOW_COLOR

  # Additional pixels the text boxes should be moved away from the event.
  # Useful if your window skin has smaller or larger borders than usual.
  HORIZONTAL_SPACING = 8
  TOP_SPACING        = 0
  BOTTOM_SPACING     = 0

  # Range from which signs will show. The vertical center is from one tile
  # below the event, not on the event itself, so it favors being in front of it.
  HORIZONTAL_RANGE = 4
  VERTICAL_RANGE   = 2

end
