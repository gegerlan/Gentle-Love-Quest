class Scene_Menu < Scene_Base
  def create_command_window
    s1 = Vocab::item
    s2 = Vocab::skill
    s3 = Vocab::equip
    s4 = Vocab::status
    s5 = Vocab::save
    s6 = Vocab::game_end
    s7 = "Achievements"
    @command_window = Window_Command.new(160, [s1, s2, s3, s4, s5,s7, s6])
    @command_window.index = @menu_index
    if $game_party.members.size == 0        # If there isn't any party members
      @command_window.draw_item(0, false)    # Disable "Items"
      @command_window.draw_item(1, false)    # Disable "Skills"
      @command_window.draw_item(2, false)    # Disable "Equipments"
      @command_window.draw_item(3, false)    # Disable "Status"
    end
    if $game_system.save_disabled          # If saving is forbidden
      @command_window.draw_item(4, false)    # Disable "Save"
    end
  end

  def update_command_selection
    if Input.trigger?(Input::B)
      Sound.play_cancel
      $scene = Scene_Map.new   elsif Input.trigger?(Input::C)
      if $game_party.members.size == 0 and @command_window.index < 4
        Sound.play_buzzer
        return
      elsif $game_system.save_disabled and @command_window.index == 4
        Sound.play_buzzer
        return
      end
      Sound.play_decision
      case @command_window.index
        when 0     # Item
          $scene = Scene_Item.new
        when 1,2,3  # Skil,equip,status
          start_actor_selection
        when 4     # Save
          $scene = Scene_File.new(true, false, false)
        when 5     # Achievements
          $scene = Scene_Achievements.new
        when 6     # End Game
          $scene = Scene_End.new
      end
    end
  end
end
