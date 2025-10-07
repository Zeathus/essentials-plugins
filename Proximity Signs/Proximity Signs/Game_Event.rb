class Game_Event < Game_Character

  def page_number
    return @event.pages.index(@page)
  end

end
