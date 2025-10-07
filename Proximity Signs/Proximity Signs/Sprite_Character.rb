class Sprite_Character < RPG::Sprite

  alias sign_initialize initialize
  alias sign_dispose dispose
  alias sign_update update

  def initialize(viewport, character = nil)
    @proximity_textboxes = {}
    sign_initialize(viewport, character)
  end

  def color=(value)
    super(value)
    @proximity_textboxes.each do |direction, textbox|
      textbox.color = value
    end
  end

  def tone=(value)
    super(value)
    @proximity_textboxes.each do |direction, textbox|
      textbox.tone = value
    end
  end

  def dispose
    @proximity_textboxes.each do |direction, textbox|
      textbox.dispose
    end
    sign_dispose
  end

  def update
    sign_update
    if $game_player && ($game_player.x - @character.x).abs <= ProximitySigns::HORIZONTAL_RANGE &&
       ($game_player.y - (@character.y + 1)).abs <= ProximitySigns::VERTICAL_RANGE
      # Show sign text if player is close enough
      @character.proximity_texts.each do |direction, text|
        textbox = @proximity_textboxes[direction]
        if textbox
          if textbox.opacity < 255
            textbox.opacity += 8
            textbox.contents_opacity += 8
          end
        else
          textbox = Window_AdvancedTextPokemon.new("")
          textbox.viewport = self.viewport
          if ProximitySigns::WINDOW_SKIN
            textbox.setSkin(ProximitySigns::WINDOW_SKIN, false)
          end
          textbox.text = ""
          pbSetSmallFont(textbox.contents)
          textbox.lineHeight = 26
          textbox.resizeToFit(text, Graphics.width * 2 / 5)
          textbox.letterbyletter = false
          textbox.text = text
          pbSetSmallFont(textbox.contents)
          textbox.opacity = 0
          textbox.contents_opacity = 0
          textbox.z = 99999
          @proximity_textboxes[direction] = textbox
        end
      end
    else
      # Hide text again when player is far away
      cleared = false
      @proximity_textboxes.each do |direction, textbox|
        textbox.opacity -= 8
        textbox.contents_opacity -= 8
        if textbox.opacity <= 0
          textbox.dispose
          cleared = true
        end
      end
      @proximity_textboxes = {} if cleared
    end
    # Update proximity sign text positions
    @proximity_textboxes.each do |direction, textbox|
      case direction
      when :left
        textbox.x = self.x - textbox.width - self.src_rect.width / 4 - ProximitySigns::HORIZONTAL_SPACING
        textbox.y = self.y - textbox.height / 2 - self.src_rect.height / 2
      when :right
        textbox.x = self.x + self.src_rect.width / 4 + ProximitySigns::HORIZONTAL_SPACING
        textbox.y = self.y - textbox.height / 2 - self.src_rect.height / 2
      when :top
        textbox.x = self.x - textbox.width / 2
        textbox.y = self.y - textbox.height - self.src_rect.height - ProximitySigns::TOP_SPACING
      when :bottom
        textbox.x = self.x - textbox.width / 2
        textbox.y = self.y + ProximitySigns::BOTTOM_SPACING
      end
    end
  end

end
