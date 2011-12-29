class Scene_Status < Scene_Base

  def update
    update_menu_background
    @status_window.update
    if Input.trigger?(Input::B)
      Sound.play_cancel
      return_scene
    elsif Input.trigger?(Input::R)
      Sound.play_cursor
      next_actor
    elsif Input.trigger?(Input::L)
      Sound.play_cursor
      prev_actor
    elsif Input.trigger?(Input::C)
      Sound.play_decision
      @status_window.nextpage
    end
    
    super
  end

end
